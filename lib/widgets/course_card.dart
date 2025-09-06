import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/views/views/course_details_page.dart';
import '../models/course.dart';
import '../controllers/vote_controller.dart';
import '../controllers/course_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../theme/AppColors.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final bool showVote;
  final bool showRegister;

  CourseCard({
    super.key,
    required this.course,
    this.showVote = false,
    this.showRegister = false,
  });

  final VoteController voteController = Get.put(VoteController());
  final CourseController courseController = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    RxInt votes = voteController.getVotes(course.id);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Get.to(() => CourseDetailsPage(courseId: course.id));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                course.title,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                course.description,
                textAlign: TextAlign.right,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (showVote)
                    Obx(() {
                      double percent = votes.value / (votes.value + 5);
                      return CircularPercentIndicator(
                        radius: 50,
                        lineWidth: 6,
                        percent: percent.clamp(0.0, 1.0),
                        center: Text(
                          '${votes.value}',
                          style: TextStyle(fontSize: 16),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.orangeAccent,
                        backgroundColor: Colors.grey.shade300,
                      );
                    }),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('المدرب: ${course.trainerName}'),
                        Text('المدة: ${course.durationHours} ساعة'),
                        Text('الموقع: ${course.location}'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              if (showVote)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  onPressed: () async {
                    await voteController.vote(course.id);
                  },
                  icon: Icon(Icons.thumb_up, color: Colors.white),
                  label: Obx(
                    () => Text(
                      '${votes.value}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              if (showRegister)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.pinkBeige,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () async {
                    final result = await courseController.register(course.id);
                    if (result['success']) {
                      Get.snackbar(
                        'نجاح',
                        result['message'],
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } else {
                      Get.snackbar(
                        'خطأ',
                        result['message'],
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  child: Text('سجل الآن', style: TextStyle(color: Colors.white)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
