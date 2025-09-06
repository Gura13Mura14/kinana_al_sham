import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/ProfileController.dart';
import 'package:kinana_al_sham/controllers/notification_controller.dart';
import 'package:kinana_al_sham/controllers/recommendation_controller.dart';
import 'package:kinana_al_sham/services/profile_service.dart';
import 'package:kinana_al_sham/services/recommendation_service.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/views/announced_course_page.dart';
import 'package:kinana_al_sham/views/opportunity_view.dart';
import 'package:kinana_al_sham/views/views/courses_vote_page.dart';
import 'package:kinana_al_sham/views/views/event_page.dart';
import 'package:kinana_al_sham/views/views/notifications_page.dart';
import 'package:kinana_al_sham/views/views/profile_details_view.dart';
import 'package:kinana_al_sham/views/views/project_view.dart';
import 'package:kinana_al_sham/views/views/side_menu.dart';
import 'package:kinana_al_sham/views/views/volunteer_home_calendar.dart';
import 'package:kinana_al_sham/views/volunteering_opportunity_list_view.dart';
import 'package:kinana_al_sham/widgets/home_category_circle.dart';
import 'package:kinana_al_sham/widgets/recommendation_card.dart';

class VolunteerHomeView extends StatelessWidget {
  final profileController = Get.put(ProfileController(ProfileService()));
  final notificationController = Get.put(NotificationController());
  final recommendationController =
      Get.put(RecommendationController(RecommendationService()));

  VolunteerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ctrl = Get.find<ProfileController>();

      // ✅ إذا البروفايل جاهز وحقل العنوان ناقص
      if (!ctrl.isLoading.value && !ctrl.isAddressComplete) {
        Future.microtask(() {
          if (Get.isDialogOpen != true) {
            Get.dialog(
              Directionality(
                textDirection: TextDirection.rtl, // لتفعيل RTL
                child: AlertDialog(
                  backgroundColor: AppColors.pureWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.darkBlue,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'مطلوب استكمال البيانات',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.darkBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  content: const Text(
                    'الرجاء تحديد العنوان (المنطقة) لإكمال الملف الشخصي.',
                    style: TextStyle(fontSize: 16),
                  ),
                  actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.pinkBeige,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      onPressed: () {
                        Get.back(); // يغلق الديالوج
                        Get.to(() => const ProfileView()); // يفتح صفحة البروفايل
                      },
                      child: const Text(
                        'إكمال الآن',
                        style: TextStyle(
                          color: AppColors.pureWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              barrierDismissible: false,
            );
          }
        });
      }

      return Scaffold(
        endDrawer:  SideMenu(),
        backgroundColor: AppColors.pureWhite,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: [
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
                      builder: (context) => IconButton(
                        icon: const Icon(
                          Icons.menu,
                          size: 28,
                          color: AppColors.darkBlue,
                        ),
                        onPressed: () => Scaffold.of(context).openEndDrawer(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "موصى به",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.pinkBeige,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // 🔹 قائمة التوصيات
                SizedBox(
                  height: 120,
                  child: Obx(() {
                    if (recommendationController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (recommendationController.recommendations.isEmpty) {
                      return const Center(child: Text("لا يوجد توصيات حالياً"));
                    }

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      itemCount:
                          recommendationController.recommendations.length,
                      itemBuilder: (context, index) {
                        final item =
                            recommendationController.recommendations[index];
                        final opportunity = item['opportunity'];

                        return RecommendationCard(
                          title: opportunity['title'] ?? '',
                          type: opportunity['category'] ?? '',
                          date: opportunity['start_date']
                                  ?.toString()
                                  .substring(0, 10) ??
                              '',
                        );
                      },
                    );
                  }),
                ),
                const SizedBox(height: 25),
                Container(
                    height: 1, color: AppColors.darkBlue.withOpacity(0.7)),
                const SizedBox(height: 10),
                SizedBox(
                  height: 80,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        HomeCategoryCircle(
                          title: 'دورات',
                          imagePath: 'lib/assets/images/courses.png',
                          onTap: () => Get.to(() => AnnouncedCoursePage()),
                        ),
                        const SizedBox(width: 16),
                          HomeCategoryCircle(
                          title: 'دورات للتصويت',
                          imagePath: 'lib/assets/images/courses.png',
                          onTap: () => Get.to(() => CoursesVotePage()),
                        ),
                        const SizedBox(width: 16),
                        HomeCategoryCircle(
                          title: 'تطوع',
                          imagePath: 'lib/assets/images/volunteer.png',
                          onTap: () => Get.to(
                              () => VolunteeringOpportunityListView()),
                        ),
                        const SizedBox(width: 16),
                        HomeCategoryCircle(
                          title: 'فرص عمل',
                          imagePath: 'lib/assets/images/jobs.jpg',
                          onTap: () => Get.to(() => OpportunityView()),
                        ),
                        const SizedBox(width: 16),
                        HomeCategoryCircle(
                          title: 'فعاليات',
                          imagePath: 'lib/assets/images/event.webp',
                          onTap: () => Get.to(() => EventsPage()),
                        ),
                        const SizedBox(width: 16),
                        HomeCategoryCircle(
                          title: 'مشاريع',
                          imagePath: 'lib/assets/images/project1.jpg',
                          onTap: () => Get.to(() => ProjectListView()),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                    height: 1, color: AppColors.darkBlue.withOpacity(0.9)),
                const SizedBox(height: 20),
                // التقويم
                SizedBox(
                  height: 500,
                  child: VolunteerHomeCalendar(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
