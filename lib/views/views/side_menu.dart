import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/services/storage_service.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, 
      child: Drawer(
        child: FutureBuilder(
          future: StorageService.getLoginData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final loginData = snapshot.data!;
            final userType = loginData['user_type'];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: AppColors.darkBlue,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.menu, color: Colors.white, size: 36),
                      const SizedBox(height: 10),
                      Text(
                        'أهلاً بك، ${loginData['user_name'] ?? ''}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      /// استفسارات
                      ListTile(
                        leading: const Icon(Icons.question_answer, color: Colors.blue),
                        title: const Text("الاستفسارات"),
                        onTap: () {
                          if (userType == 'متطوع') {
                            Get.toNamed('/inquiries/volunteer');
                          } else {
                            Get.toNamed('/inquiries/beneficiary');
                          }
                        },
                      ),

                      /// بروفايلي
                      ListTile(
                        leading: const Icon(Icons.person, color: Colors.green),
                        title: const Text("بروفايلي"),
                        onTap: () {
                          if (userType == 'متطوع') {
                            Get.toNamed('/profile/volunteer');
                          } else {
                            Get.toNamed('/profile/beneficiary');
                          }
                        },
                      ),

                      /// لوحة الشرف
                      ListTile(
                        leading: const Icon(Icons.star, color: Colors.amber),
                        title: const Text("لوحة الشرف"),
                        onTap: () {
                          if (userType == 'متطوع') {
                            Get.toNamed('/honor-board/volunteer');
                          } else {
                            Get.toNamed('/honor-board/beneficiary');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
