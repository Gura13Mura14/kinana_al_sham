import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/services/get_event_voulenter_service.dart';

import 'package:kinana_al_sham/services/storage_service.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

import 'package:kinana_al_sham/views/views/my_event_page.dart';
import 'package:kinana_al_sham/views/views/my_project_view.dart';

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
                  decoration: BoxDecoration(color: AppColors.darkBlue),
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
                        leading: const Icon(
                          Icons.question_answer,
                          color: Colors.blue,
                        ),
                        title: const Text("الاستفسارات"),
                        onTap: () {
                          if (userType == 'متطوع') {
                            Get.toNamed('/Inquiry');
                          } else {
                            Get.toNamed('/Inquiry');
                          }
                        },
                      ),

                      /// بروفايلي
                      ListTile(
                        leading: const Icon(Icons.person, color: Colors.green),
                        title: const Text("بروفايلي"),
                        onTap: () {
                          if (userType == 'متطوع') {
                            Get.toNamed('/profile-details');
                          } else {
                            Get.toNamed('/beneficiary-profile');
                          }
                        },
                      ),
                      /// لوحة الشرف
                      ListTile(
                        leading: const Icon(Icons.star, color: Colors.amber),
                        title: const Text("لوحة الشرف"),
                        onTap: () {
                          if (userType == 'متطوع') {
                            Get.toNamed('/HonorBoard');
                          } else {
                            Get.toNamed('/HonorBoard');
                          }
                        },
                      ),
                      if (userType == 'متطوع') ...[
                        ListTile(
                          leading: const Icon(
                            Icons.work,
                            color: Colors.deepPurple,
                          ),
                          title: const Text("طلباتي"),
                          onTap: () {
                            Get.toNamed('/my_applications');
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.emergency,
                            color: Colors.black,
                          ),
                          title: const Text("المساعدات الطارئة"),
                          onTap: () {
                            Get.toNamed('/emergency_requests');
                          },
                        ),

                        ListTile(
                          leading: const Icon(
                            Icons.event,
                            color: Colors.purple,
                          ),
                          title: const Text("فعاليتي"),
                          onTap: () async {
                            final events =
                                await EventVolunteerService.getMyEvents();
                            Get.to(
                              () => const MyEventsPage(),
                              arguments: events,
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.dashboard_sharp,
                            color: Colors.orangeAccent,
                          ),
                          title: const Text("مشاريعي "),
                          onTap: () {
                            Get.to(() => const MyProjectsPage());
                          },
                        ),
                      ],
                      if (userType == 'مستفيد') ...[
                        ListTile(
                          leading: const Icon(
                            Icons.request_page,
                            color: Colors.deepPurple,
                          ),
                          title: const Text("طلب مساعدة"),
                          onTap: () {
                            Get.toNamed('/request_assistance');
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.assignment,
                            color: Colors.teal,
                          ),
                          title: const Text("طلباتي"),
                          onTap: () {
                            Get.toNamed('/beni_requests');
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.text_snippet,
                            color: Colors.teal,
                          ),
                          title: const Text('كتابة قصة نجاح'),
                          onTap: () {
                            Get.toNamed('/success_story_form');
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.text_snippet,
                            color: Colors.teal,
                          ),
                          title: const Text('قصص نجاحي'),
                          onTap: () {
                            Get.toNamed('/review_stories');
                          },
                        ),

                        ListTile(
                          leading: const Icon(
                            Icons.help_outline,
                            color: Colors.teal,
                          ),
                          title: const Text("طلب مساعدة طارئة"),
                          onTap: () {
                            Get.toNamed('/beneficiary_emergency_request');
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.help, color: Colors.teal),
                          title: const Text('طلبات مساعدة طارئة'),
                          onTap: () {
                            Get.toNamed('/beni_emergency_requests');
                          },
                        ),
                      ],
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