import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/ProfileController.dart';
import 'package:kinana_al_sham/services/profile_service.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/views/opportunity_view.dart';
import 'package:kinana_al_sham/views/views/courses_list.dart';
import 'package:kinana_al_sham/views/views/event_page.dart';
import 'package:kinana_al_sham/views/views/project_view.dart';
import 'package:kinana_al_sham/views/views/side_menu.dart';
import 'package:kinana_al_sham/views/views/volunteer_home_calendar.dart';
import 'package:kinana_al_sham/views/volunteering_opportunity_list_view.dart';
import 'package:kinana_al_sham/widgets/home_category_circle.dart';
import 'package:kinana_al_sham/widgets/recommendation_card.dart';

class VolunteerHomeView extends StatelessWidget {
  final profileController = Get.put(ProfileController(ProfileService()));

  VolunteerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const SideMenu(),
      backgroundColor: AppColors.pureWhite,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    final user = profileController.user.value;
                    final imageUrl = user?.profilePictureUrl;

                    return GestureDetector(
                      onTap: () => Get.toNamed('/profile-details'),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            imageUrl != null
                                ? NetworkImage(imageUrl)
                                : const AssetImage(
                                      'lib/assets/images/Profile1.webp',
                                    )
                                    as ImageProvider,
                      ),
                    );
                  }),
                  Builder(
                    builder:
                        (context) => IconButton(
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

              const SizedBox(height: 40),

              // 🔹 قائمة التوصيات أفقي (Right to Left)
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  reverse: true, // لتكون من اليمين لليسار
                  children: const [
                    RecommendationCard(
                      title: 'دورة ريادة أعمال',
                      type: 'تعليم',
                      date: '12/09/2025',
                    ),
                    RecommendationCard(
                      title: 'ورشة تكنولوجيا',
                      type: 'تطوير',
                      date: '15/09/2025',
                    ),
                    RecommendationCard(
                      title: 'مشروع تطوعي',
                      type: 'تطوع',
                      date: '18/09/2025',
                    ),
                    RecommendationCard(
                      title: 'فرصة تدريبية',
                      type: 'تعليم',
                      date: '20/09/2025',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // الخط العلوي
              Container(height: 1, color: AppColors.darkBlue.withOpacity(0.3)),

              const SizedBox(height: 10),

              // 🔹 Categories Horizontal
              SizedBox(
                height: 80,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      HomeCategoryCircle(
                        title: 'دورات',
                        imagePath: 'lib/assets/images/courses.png',
                        onTap: () => Get.to(() => CoursesListPage()),
                      ),
                      const SizedBox(width: 16),
                      HomeCategoryCircle(
                        title: 'تطوع',
                        imagePath: 'lib/assets/images/volunteer.png',
                        onTap:
                            () =>
                                Get.to(() => VolunteeringOpportunityListView()),
                      ),
                      const SizedBox(width: 16),
                      HomeCategoryCircle(
                        title: 'فرص عمل',
                        imagePath: 'lib/assets/images/jobs.jpg',
                        onTap: () => Get.to(() => OpportunityView()),
                      ),
                      const SizedBox(width: 16),
                      HomeCategoryCircle(
                        title: 'تبرعات',
                        imagePath: 'lib/assets/images/donation.png',
                        onTap: () {},
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

              // الخط السفلي
              Container(height: 1, color: AppColors.darkBlue.withOpacity(0.3)),

              const SizedBox(height: 20),

              // التقويم
              SizedBox(
                height: 500, // اضبط على حسب الحاجة
                child: VolunteerHomeCalendar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
