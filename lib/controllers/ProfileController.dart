import 'package:get/get.dart';
import 'package:flutter/material.dart';
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

  Future<void> save() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final token = await _token();
    if (token == null) {
      Get.snackbar('خطأ', 'لا يوجد صلاحية');
      return;
    }

    final updatedData = {
      'skills': skillsController.text.trim(),
      'interests': interestsController.text.trim(),
      'emergency_contact_name': emergencyNameController.text.trim(),
      'emergency_contact_phone': emergencyPhoneController.text.trim(),
      'address': selectedDistrict.value ?? '',
      'phone_number': phoneController.text.trim(),
    };

    final ok = await service.updateVolunteerProfile(token, updatedData);
    if (ok) {
      Get.snackbar('نجاح', 'تم تحديث الملف الشخصي');
      await fetchUserProfile();
      isEditing.value = false;
    } else {
      Get.snackbar('خطأ', 'فشل التحديث');
    }
  }
}
