import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/ProfileController.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/utils/app_constants.dart';
import 'package:kinana_al_sham/widgets/responsive_sizes.dart';

class EditProfileView extends GetView<ProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Directionality(
      textDirection: TextDirection.rtl, // لتفعيل RTL
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('تعديل الملف الشخصي'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Get.back(),
          ),
        ),
        extendBodyBehindAppBar: true, // لتظهر الخلفية أسفل الـ AppBar
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.pureWhite, AppColors.grayWhite, AppColors.pinkBeige],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          padding: EdgeInsets.all(r.wp(5)),
          child: Form(
            key: controller.formKey,
            child: ListView(
              children: [
                _roundedField(
                  controller.skillsController,
                  'المهارات',
                  Icons.design_services,
                  r: r,
                ),
                SizedBox(height: r.hp(1.5)),
                _roundedField(
                  controller.interestsController,
                  'الاهتمامات',
                  Icons.favorite,
                  r: r,
                ),
                SizedBox(height: r.hp(1.5)),
                _roundedField(
                  controller.phoneController,
                  'رقم الهاتف',
                  Icons.phone,
                  keyboardType: TextInputType.phone,
                  r: r,
                ),
                SizedBox(height: r.hp(1.5)),
                _roundedField(
                  controller.emergencyNameController,
                  'اسم جهة الطوارئ',
                  Icons.person,
                  r: r,
                ),
                SizedBox(height: r.hp(1.5)),
                _roundedField(
                  controller.emergencyPhoneController,
                  'رقم هاتف جهة الطوارئ',
                  Icons.local_phone,
                  keyboardType: TextInputType.phone,
                  r: r,
                ),
                SizedBox(height: r.hp(1.5)),

                DropdownButtonFormField<String>(
                  value: controller.selectedDistrict.value,
                  isExpanded: true,
                  items: AppConstants.damascusDistricts
                      .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                      .toList(),
                  decoration: _roundedDecoration(
                    label: 'المنطقة في دمشق',
                    icon: Icons.location_on,
                  ),
                  onChanged: (v) => controller.selectedDistrict.value = v,
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'الرجاء اختيار المنطقة' : null,
                ),

                SizedBox(height: r.hp(3)),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save,color: AppColors.pureWhite,),
                    label: const Text('حفظ التعديلات',style: TextStyle(color: AppColors.pureWhite)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                      padding: EdgeInsets.symmetric(vertical: r.hp(1.8)),
                      textStyle: TextStyle(
                        fontSize: r.sp(16),
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: () async {
                      final ok = await controller.save();
                      if (ok) {
                        Get.back();
                        Get.snackbar(
                          'نجاح',
                          'تم تحديث الملف الشخصي بنجاح',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.pureWhite,
                          colorText: AppColors.darkBlue,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _roundedField(
    TextEditingController ctrl,
    String label,
    IconData icon, {
    TextInputType? keyboardType,
    required Responsive r,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboardType,
      decoration: _roundedDecoration(label: label, icon: icon),
      validator: (v) => (v == null || v.trim().isEmpty) ? 'الحقل مطلوب' : null,
      textAlign: TextAlign.right, // يجعل النص من اليمين لليسار
    );
  }

  InputDecoration _roundedDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(color: AppColors.darkBlue),
      ),
    );
  }
}
