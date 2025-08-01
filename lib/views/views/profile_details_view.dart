import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/ProfileController.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/widgets/CustomButton.dart';

class ProfileDetailsView extends StatelessWidget {
  final profileController = Get.find<ProfileController>();

  ProfileDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.grayWhite,
        appBar: AppBar(
          backgroundColor: AppColors.pureWhite,
          title: const Text(
            'الملف الشخصي',
            style: TextStyle(color: AppColors.darkBlue),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Obx(() {
          final user = Get.find<ProfileController>().user.value;
          if (user == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        profileController.profilePictureUrl.isNotEmpty
                            ? NetworkImage(
                                profileController.profilePictureUrl.value,
                              )
                            : const AssetImage('lib/assets/images/Profile1.webp')
                                as ImageProvider,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.bluishGray,
                  ),
                ),
                const SizedBox(height: 30),

                // Container يحتوي على باقي المعلومات
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow('الهوية', user.id.toString()),
                      _buildInfoRow(
                          'رقم الهاتف', user.phoneNumber ?? 'غير متوفر'),
                      _buildInfoRow('المهارات',
                          user.volunteerDetails?.skills ?? 'غير محددة'),
                      _buildInfoRow('الاهتمامات',
                          user.volunteerDetails?.interests ?? 'غير محددة'),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'تعديل الملف الشخصي',
                        onPressed: () {
                          Get.toNamed('/update-profile'); // ← مسار التحديث
                        },
                        color: AppColors.darkBlue,
                        textcolor: Colors.white,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
