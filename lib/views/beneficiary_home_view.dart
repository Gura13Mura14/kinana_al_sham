import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/ProfileController.dart';
import 'package:kinana_al_sham/controllers/notification_controller.dart';
import 'package:kinana_al_sham/controllers/success_story_controller.dart';
import 'package:kinana_al_sham/services/profile_service.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

import 'package:kinana_al_sham/views/views/courses_list_page.dart';
import 'package:kinana_al_sham/views/views/event_page.dart';
import 'package:kinana_al_sham/views/views/notifications_page.dart';
import 'package:kinana_al_sham/views/views/side_menu.dart';
import 'package:kinana_al_sham/views/views/association_growth_chart.dart';
import 'package:kinana_al_sham/widgets/home_category_circle.dart';
import 'package:kinana_al_sham/views/views/project_view.dart';
import 'package:kinana_al_sham/widgets/success_stories_list.dart';

class BeneficiaryHomeView extends StatefulWidget {
  const BeneficiaryHomeView({super.key});

  @override
  State<BeneficiaryHomeView> createState() => _BeneficiaryHomeViewState();
}

class _BeneficiaryHomeViewState extends State<BeneficiaryHomeView> {
  final profileController = Get.put(ProfileController(ProfileService()));
  final successStoryController = Get.put(SuccessStoryController());
  final notificationController = Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    successStoryController.loadApprovedStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:  SideMenu(),
      backgroundColor: AppColors.grayWhite,
      body: Column(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // الصف العلوي: صورة الملف و زر القائمة
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            size: 28,
                            color: AppColors.darkBlue,
                          ),
                          onPressed: () {
                            Get.to(() => NotificationsPage());
                          },
                        ),

                        Builder(
                          builder:
                              (context) => Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  color: AppColors.pureWhite,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.menu,
                                    size: 28,
                                    color: AppColors.darkBlue,
                                  ),
                                  onPressed:
                                      () =>
                                          Scaffold.of(context).openEndDrawer(),
                                ),
                              ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    Container(
                      height: 1,
                      color: AppColors.darkBlue.withOpacity(0.3),
                    ),
                    // الدوائر الأفقية للخدمات
                    SizedBox(
                      height: 100,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HomeCategoryCircle(
                              size: 70,
                              title: 'دورات',
                              imagePath: 'lib/assets/images/courses.png',
                              onTap: () {
                                Get.to(() => CoursesListPage());
                              },
                            ),
                            const SizedBox(width: 40),
                            HomeCategoryCircle(
                              size: 70,
                              title: 'فعاليات',
                              imagePath: 'lib/assets/images/event.webp',
                              onTap: () {
                                Get.to(() => EventsPage());
                              },
                            ),
                            const SizedBox(width: 40),
                            HomeCategoryCircle(
                              size: 70,
                              title: 'مشاريع ',
                              imagePath: 'lib/assets/images/project1.jpg',
                              onTap: () {
                                Get.to(() => ProjectListView());
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      height: 1,
                      color: AppColors.darkBlue.withOpacity(0.3),
                    ),
                    const SizedBox(height: 20),

                    // عنوان الرسم البياني
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'تطور أعمال الجمعية خلال آخر 5 سنوات',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              foreground:
                                  Paint()
                                    ..shader = const LinearGradient(
                                      colors: [
                                        AppColors.darkBlue,
                                        AppColors.pinkBeige,
                                      ],
                                    ).createShader(
                                      const Rect.fromLTWH(100, 0, 300, 70),
                                    ),
                              shadows: [
                                Shadow(
                                  color: Colors.black26,
                                  offset: Offset(1, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            width: 260,
                            height: 2,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.pinkBeige,
                                  AppColors.darkBlue,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 38),

                    // رسم بياني
                    StatisticsChartView(),

                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'قصص النجاح',
                        style: TextStyle(
                          color: AppColors.darkBlue,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                    Obx(() {
                      if (successStoryController.stories.isEmpty) {
                        return const Center(
                          child: Text("لا توجد قصص نجاح حالياً"),
                        );
                      }
                      return SuccessStoriesList(
                        stories: successStoryController.stories,
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
