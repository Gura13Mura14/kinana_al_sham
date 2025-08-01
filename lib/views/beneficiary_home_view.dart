import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/ProfileController.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/views/views/side_menu.dart';
import 'package:kinana_al_sham/views/views/association_growth_chart.dart';
import 'package:kinana_al_sham/widgets/home_category_circle.dart';

class BeneficiaryHomeView extends StatelessWidget {
  final profileController = Get.put(ProfileController());

  BeneficiaryHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const SideMenu(),
      backgroundColor: AppColors.grayWhite,
      body: Container(
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
                    Obx(() {
                      final user = profileController.user.value;
                      final imageUrl = user?.profilePictureUrl;

                      return GestureDetector(
                        onTap: () => Get.toNamed('/beneficiary-profile'),
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: AppColors.pureWhite,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
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
                                  () => Scaffold.of(context).openEndDrawer(),
                            ),
                          ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // الدوائر الأفقية للخدمات
                SizedBox(
                  height: 120,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HomeCategoryCircle(
                          size: 70,
                          title: 'دورات',
                          imagePath: 'lib/assets/images/courses.png',
                          onTap: () {},
                        ),
                        const SizedBox(width: 40),
                        HomeCategoryCircle(
                          size: 70,
                          title: 'فعاليات',
                          imagePath: 'lib/assets/images/event.webp',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
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
                        width: 260, // 🔹 طول الخط (يمكنك تعديله حسب النص)
                        height: 2,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.pinkBeige, AppColors.darkBlue, ],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 38),

                // رسم بياني
                const AssociationGrowthChart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
