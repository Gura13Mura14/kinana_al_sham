import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/ProfileController.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

class ProfileDetailsView extends StatelessWidget {
  final profileController = Get.find<ProfileController>();

  ProfileDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayWhite,
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        title: const Text(
          'الملف الشخصي',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        final user = profileController.user.value;
        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    profileController.profilePictureUrl.isNotEmpty
                        ? NetworkImage(
                          profileController.profilePictureUrl.value,
                        )
                        : const AssetImage('lib/assets/images/profile.png')
                            as ImageProvider,
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
              const SizedBox(height: 10),
              Text(
                user.email,
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.bluishGray,
                ),
              ),
              const SizedBox(height: 30),
              // أي معلومات إضافية حابب تعرضها
              // مثال:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('الهوية:', style: TextStyle(fontSize: 16)),
                  Text(
                    user.id.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('المهارات:', style: TextStyle(fontSize: 16)),
                  Text(
                    user.volunteerDetails?.skills ?? 'غير محددة',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('الاهتمامات:', style: TextStyle(fontSize: 16)),
                  Text(
                    user.volunteerDetails?.interests ?? 'غير محددة',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('رقم الهاتف:', style: TextStyle(fontSize: 16)),
                  Text(user.phoneNumber, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
