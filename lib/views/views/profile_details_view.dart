import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/ProfileController.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/views/views/update_profile_view.dart';
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
                            onPressed:
                                () => Get.to(() => const EditProfileView()),
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: r.sp(22),
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

                // معلومات البروفايل
                // معلومات البروفايل
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
                    child: Column(
                      children: [
                        _infoRow('الاسم', user.name, r),
                        _infoRow('البريد', user.email, r),
                       
                        _infoRow(
                          'رقم جهة الطوارئ',
                          user.volunteerDetails?.emergencyContactPhone ??
                              'غير محدد',
                          r,
                        ),
                        _infoRow(
                          'المنطقة',
                          user.volunteerDetails?.address?.isNotEmpty ?? false
                              ? user.volunteerDetails!.address
                              : 'غير محددة',
                          r,
                        ),
                        _infoRow(
                          'المهارات',
                          user.volunteerDetails?.skills ?? 'غير محددة',
                          r,
                        ),
                        _infoRow(
                          'الاهتمامات',
                          user.volunteerDetails?.interests ?? 'غير محددة',
                          r,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _infoRow(String label, String value, Responsive r) {
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
