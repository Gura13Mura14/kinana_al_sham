import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kinana_al_sham/models/VolunteerDetails.dart';
import 'package:kinana_al_sham/services/profile_service.dart';
import 'package:kinana_al_sham/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kinana_al_sham/models/simple_user_model.dart';

class ProfileController extends GetxController {
  final ProfileService service;
  ProfileController(this.service);

  final user = Rxn<SimpleUser>();
  final isLoading = false.obs;
  final isEditing = false.obs;

  // صورة الملف
  final profilePictureUrl = ''.obs;
  // حقول التحرير
  final skillsController = TextEditingController();
  final interestsController = TextEditingController();
  final emergencyNameController = TextEditingController();
  final emergencyPhoneController = TextEditingController();
  final phoneController = TextEditingController();
  final selectedDistrict = RxnString();

  final formKey = GlobalKey<FormState>();

  bool get isAddressComplete {
    final addr = user.value?.volunteerDetails?.address;
    return addr != null && addr.trim().isNotEmpty;
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<String?> _token() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    try {
      final token = await _token();
      if (token == null) throw Exception('No token');

      final fetched = await service.fetchProfile(token);
      user.value = fetched;

      // صورة
      final url = await service.fetchProfilePicture(fetched.id);
      if (url != null) {
        profilePictureUrl.value = url;
        user.value = user.value?.copyWith(profilePictureUrl: url);
      }

      // تهيئة الحقول من الموديل
      _fillControllersFromModel();
    } catch (e) {
      Get.snackbar('خطأ', 'فشل في جلب الملف الشخصي');
    } finally {
      isLoading.value = false;
    }
  }

  void _fillControllersFromModel() {
    final u = user.value;
    if (u == null) return;
    skillsController.text = u.volunteerDetails?.skills ?? '';
    interestsController.text = u.volunteerDetails?.interests ?? '';
    emergencyNameController.text =
        u.volunteerDetails?.emergencyContactName ?? '';
    emergencyPhoneController.text =
        u.volunteerDetails?.emergencyContactPhone ?? '';
    phoneController.text = u.phoneNumber ?? '';

    final addr = u.volunteerDetails?.address ?? '';
    if (AppConstants.damascusDistricts.contains(addr)) {
      selectedDistrict.value = addr;
    } else {
      selectedDistrict.value = null; // غير محدد أو غير موجود
    }
  }

  void toggleEdit() {
    isEditing.toggle();
    if (isEditing.isTrue) {
      _fillControllersFromModel();
    }
  }

Future<bool> save() async {
  if (formKey.currentState?.validate() != true) return false;

  isLoading.value = true;
  try {
    final token = await _token();
    if (token == null) throw Exception('No token');

    // بيانات التحديث
    final updatedData = {
      "skills": skillsController.text,
      "interests": interestsController.text,
      "emergency_contact_name": emergencyNameController.text,
      "emergency_contact_phone": emergencyPhoneController.text,
      "phone_number": phoneController.text,
      "address": selectedDistrict.value ?? '',
    };

    // إرسال التحديث للسيرفر
    final success = await service.updateVolunteerProfile(token, updatedData);

    if (success) {
      // إذا volunteerDetails موجودة استخدم copyWith، إذا null أنشئ نسخة جديدة
      final currentUser = user.value;
      if (currentUser != null) {
        final updatedVolunteer = currentUser.volunteerDetails?.copyWith(
              skills: skillsController.text,
              interests: interestsController.text,
              emergencyContactName: emergencyNameController.text,
              emergencyContactPhone: emergencyPhoneController.text,
              address: selectedDistrict.value ?? '',
            ) ??
            VolunteerDetails(
              userId: currentUser.id,
              skills: skillsController.text,
              interests: interestsController.text,
              availabilitySchedule: {}, // يمكنك إضافة قيمة افتراضية
              emergencyContactName: emergencyNameController.text,
              emergencyContactPhone: emergencyPhoneController.text,
              dateJoinedFromForm: '', // ضع قيمة افتراضية مناسبة
              address: selectedDistrict.value ?? '',
              createdAt: '', // ضع قيمة افتراضية مناسبة
              updatedAt: '', // ضع قيمة افتراضية مناسبة
            );

        // تحديث user.value محلياً
        user.value = currentUser.copyWith(volunteerDetails: updatedVolunteer);
      }

      Get.snackbar('نجاح', 'تم تحديث الملف الشخصي بنجاح');
      return true;
    } else {
      Get.snackbar('خطأ', 'تعذر تحديث الملف الشخصي');
      return false;
    }
  } catch (e) {
    Get.snackbar('خطأ', 'تعذر تحديث الملف الشخصي');
    return false;
  } finally {
    isLoading.value = false;
  }
}


}
