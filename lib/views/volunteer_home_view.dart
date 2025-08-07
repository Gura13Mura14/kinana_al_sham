import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/ProfileController.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/views/opportunity_view.dart';
import 'package:kinana_al_sham/views/views/side_menu.dart';
import 'package:kinana_al_sham/views/views/volunteer_home_calendar.dart';
import 'package:kinana_al_sham/views/volunteering_opportunity_list_view.dart';
import 'package:kinana_al_sham/widgets/home_category_circle.dart';

class VolunteerHomeView extends StatelessWidget {
  final profileController = Get.put(ProfileController());

  VolunteerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        endDrawer: const SideMenu(),
        backgroundColor: AppColors.pureWhite,
        body: Container(
          decoration: const BoxDecoration(
            gradient: SweepGradient(
              colors: [
                AppColors.pinkBeige,
                AppColors.bluishGray,
                AppColors.pureWhite,
      
                AppColors.pureWhite,
      
                AppColors.pureWhite,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        final user = profileController.user.value;
                        final imageUrl = user?.profilePictureUrl;
      
                        return GestureDetector(
                          onTap: () => Get.toNamed('/profile-details'),
                          child: Container(
                            padding: const EdgeInsets.all(
                              3,
                            ), // تحكم بسماكة اللون المحيط
                            decoration: BoxDecoration(
                              color: AppColors.pureWhite,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: Offset(
                                    0,
                                    2,
                                  ), // اتجاه الظل (يمين/يسار - أعلى/أسفل)
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
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
                          ),
                        );
                      }),
      
                      Builder(
                        builder:
                            (context) => Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 6,
                                    offset: Offset(
                                      0,
                                      2,
                                    ), // اتجاه الظل (يمين/يسار - أعلى/أسفل)
                                  ),
                                ],
                                color:
                                    AppColors
                                        .pureWhite, // استبدل هذا اللون باللون الذي تريده
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.menu,
                                  size: 28,
                                  color: AppColors.darkBlue,
                                ),
                                onPressed:
                                    () => Scaffold.of(context).openEndDrawer(),
                              ),
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Column(
                    children: [
                      // ✅ الخط العلوي
                      Container(
                        height: 1,
                        color: AppColors.darkBlue.withOpacity(
                          0.3,
                        ), 
                        margin: const EdgeInsets.symmetric(vertical: 10),
                      ),
      
                      SizedBox(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            HomeCategoryCircle(
                              title: 'دورات',
                              imagePath: 'lib/assets/images/courses.png',
                              onTap: () {},
                            ),
                            const SizedBox(width: 16),
                            HomeCategoryCircle(
                              title: 'تطوع',
                              imagePath: 'lib/assets/images/volunteer.png',
                              onTap: () {
                                Get.to(() => VolunteeringOpportunityListView());
                              },
                            ),
                            const SizedBox(width: 16),
                            HomeCategoryCircle(
                              title: 'فرص عمل',
                              imagePath: 'lib/assets/images/jobs.jpg',
                              onTap: () {
                                Get.to(() => OpportunityView());
                              },
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
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
      
                      // ✅ الخط السفلي
                      Container(
                        height: 1,
                        color: AppColors.darkBlue.withOpacity(
                          0.3,
                        ), // غيّر اللون حسب رغبتك
                        margin: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ],
                  ),
      
                  const SizedBox(height: 40),
      
                  // التقويم
                  const Expanded(child: VolunteerHomeCalendar()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
