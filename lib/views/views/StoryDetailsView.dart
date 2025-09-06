import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/success_story_controller.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/widgets/responsive_sizes.dart';

class StoryDetailsView extends StatefulWidget {
  final int storyId;
  const StoryDetailsView({super.key, required this.storyId});

  @override
  State<StoryDetailsView> createState() => _StoryDetailsViewState();
}

class _StoryDetailsViewState extends State<StoryDetailsView> {
  final controller = Get.put(SuccessStoryController());

  double _scale = 0.8;
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    controller.loadStoryDetails(widget.storyId);

    // نعمل trigger للأنيميشن بعد أول فريم
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _scale = 1;
        _opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.pureWhite, AppColors.grayWhite, AppColors.pinkBeige],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Obx(() {
            final story = controller.selectedStory.value;
            if (story == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Stack(
              children: [
                // زر إغلاق
                Positioned(
                  top: r.hp(5),
                  right: r.wp(5),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.darkBlue, size: 28),
                    onPressed: () => Get.back(),
                  ),
                ),

                // الرسالة
                Center(
                  child: AnimatedScale(
                    scale: _scale,
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.easeOutBack,
                    child: AnimatedOpacity(
                      opacity: _opacity,
                      duration: const Duration(milliseconds: 1500),
                      child: Container(
                        width: r.wp(85),
                        padding: EdgeInsets.all(r.wp(5)),
                        margin: EdgeInsets.only(top: r.hp(8)), // تخليها تنزل شوي لتبين كرسالة
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // صورة القصة
                              if (story.imageUrl != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    story.imageUrl!,
                                    width: double.infinity,
                                    height: r.hp(25),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              SizedBox(height: r.hp(2)),

                              // العنوان
                              Text(
                                story.title,
                                style: TextStyle(
                                  fontSize: r.sp(20),
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkBlue,
                                ),
                              ),
                              SizedBox(height: r.hp(1.5)),

                              // التفاصيل
                              Text(
                                story.content,
                                style: TextStyle(
                                  fontSize: r.sp(15),
                                  color: Colors.black87,
                                  height: 1.6,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: r.hp(2)),

                              // المرسل
                              Row(
                                children: [
                                  if (story.submittedByPicture != null)
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(story.submittedByPicture!),
                                      radius: r.wp(6),
                                    ),
                                  SizedBox(width: r.wp(3)),
                                  Expanded(
                                    child: Text(
                                      "بقلم: ${story.submittedByName ?? 'غير معروف'}",
                                      style: TextStyle(
                                        fontSize: r.sp(13),
                                        color: AppColors.bluishGray,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: r.hp(2)),

                              // التاريخ
                              if (story.submissionDate != null)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "📅 ${story.submissionDate}",
                                    style: TextStyle(
                                      fontSize: r.sp(12),
                                      color: AppColors.bluishGray,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
