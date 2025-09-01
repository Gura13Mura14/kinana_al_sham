import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/ProfileController.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/utils/app_constants.dart';
import 'package:kinana_al_sham/widgets/responsive_sizes.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.grayWhite,
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = controller.user.value;
          if (user == null) {
            return const Center(child: Text('لا توجد بيانات'));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                    r.wp(5),
                    r.hp(5),
                    r.wp(5),
                    r.hp(5),
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.darkBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28),
                    ),
                  ),
                  child: Column(
                    children: [
                      // زر الرجوع + زر التعديل
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: r.sp(20),
                            ),
                          ),
                          IconButton(
                            onPressed: () => controller.isEditing.toggle(),
                            icon: Obx(
                              () => Icon(
                                controller.isEditing.value
                                    ? Icons.close
                                    : Icons.edit,
                                color: Colors.white,
                                size: r.sp(22),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: r.hp(1.5)),

                      // صورة البروفايل
                      CircleAvatar(
                        radius: r.wp(15),
                        backgroundImage:
                            controller.profilePictureUrl.value.isNotEmpty
                                ? NetworkImage(
                                  controller.profilePictureUrl.value,
                                )
                                : const AssetImage(
                                      'lib/assets/images/Profile1.webp',
                                    )
                                    as ImageProvider,
                      ),
                      SizedBox(height: r.hp(1.5)),

                      // الاسم
                      Text(
                        user.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: r.sp(22),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: r.hp(0.5)),

                      // البريد
                      Text(
                        user.email,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: r.sp(14),
                        ),
                      ),
                      SizedBox(height: r.hp(2)),
                    ],
                  ),
                ),

                // الكارد الأبيض للمعلومات
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: r.wp(5),
                    vertical: r.hp(2),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(r.wp(4)),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Obx(() {
                      final editing = controller.isEditing.value;
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeIn,
                        transitionBuilder:
                            (child, anim) => SizeTransition(
                              sizeFactor: anim,
                              child: FadeTransition(
                                opacity: anim,
                                child: child,
                              ),
                            ),
                        child:
                            editing
                                ? _EditForm(
                                  key: const ValueKey('edit'),
                                  controller: controller,
                                  r: r,
                                )
                                : _ReadOnlyInfo(
                                  key: const ValueKey('read'),
                                  user: user,
                                  r: r,
                                ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// -------------------- ReadOnly Info --------------------
class _ReadOnlyInfo extends StatelessWidget {
  const _ReadOnlyInfo({super.key, required this.user, required this.r});
  final dynamic user;
  final Responsive r;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _infoRow('الاسم', user.name),
        _infoRow('البريد', user.email),
        _infoRow('رقم الهاتف', user.phoneNumber ?? 'غير متوفر'),
        _infoRow(
          'المنطقة',
          (user.volunteerDetails?.address?.isNotEmpty ?? false)
              ? user.volunteerDetails!.address
              : 'غير محددة',
        ),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: r.hp(1.2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: r.sp(14), color: AppColors.bluishGray),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: r.sp(15)),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------- Edit Form --------------------
class _EditForm extends StatelessWidget {
  const _EditForm({super.key, required this.controller, required this.r});
  final ProfileController controller;
  final Responsive r;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          _roundedField(
            controller.skillsController,
            'المهارات',
            Icons.design_services,
          ),
          SizedBox(height: r.hp(1.5)),
          _roundedField(
            controller.interestsController,
            'الاهتمامات',
            Icons.favorite,
          ),
          SizedBox(height: r.hp(1.5)),
          _roundedField(
            controller.phoneController,
            'رقم الهاتف',
            Icons.phone,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: r.hp(1.5)),
          _roundedField(
            controller.emergencyNameController,
            'اسم جهة الطوارئ',
            Icons.person,
          ),
          SizedBox(height: r.hp(1.5)),
          _roundedField(
            controller.emergencyPhoneController,
            'رقم هاتف جهة الطوارئ',
            Icons.local_phone,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: r.hp(1.5)),

          DropdownButtonFormField<String>(
            value: controller.selectedDistrict.value,
            isExpanded: true,
            items:
                AppConstants.damascusDistricts
                    .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
            decoration: _roundedDecoration(
              label: 'المنطقة في دمشق',
              icon: Icons.location_on,
            ),
            onChanged: (v) => controller.selectedDistrict.value = v,
            validator:
                (v) =>
                    (v == null || v.isEmpty) ? 'الرجاء اختيار المنطقة' : null,
          ),

          SizedBox(height: r.hp(3)),
          // زر الحفظ
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('حفظ التعديلات'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkBlue,
                padding: EdgeInsets.symmetric(vertical: r.hp(1.8)),
                textStyle: TextStyle(
                  fontSize: r.sp(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: controller.save,
            ),
          ),
        ],
      ),
    );
  }

  TextFormField _roundedField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: _roundedDecoration(label: label, icon: icon),
      validator: (v) => (v == null || v.trim().isEmpty) ? 'الحقل مطلوب' : null,
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
