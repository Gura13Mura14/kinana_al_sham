import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/courses_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../models/course.dart';
import '../theme/AppColors.dart';
import '../controllers/vote_controller.dart';
import '../controllers/course_controller.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  CourseCard({super.key, required this.course});

  final VoteController voteController = Get.put(VoteController());
  final CourseController courseController = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    RxInt votes = voteController.getVotes(course.id);

    // اعتبار أن الدورة قيد التصويت إذا votesCount أقل من عدد معين
    bool isVoting = course.votesCount < 1;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // عنوان الدورة
            Text(course.title,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            // وصف الدورة
            Text(course.description,
                textAlign: TextAlign.right, maxLines: 2, overflow: TextOverflow.ellipsis),
            SizedBox(height: 12),
            // صف المعلومات والدائرة مع تبديل الجهة
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // تفاصيل الدورة على اليسار
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('المدرب: ${course.trainerName}'),
                      Text('المدة: ${course.durationHours} ساعة'),
                      Text('الموقع: ${course.location}'),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                // دائرة التصويت على اليمين
                Obx(() {
                  double percent = votes.value / (votes.value + 5); // مثال للنسبة
                  return CircularPercentIndicator(
                    radius: 50,
                    lineWidth: 6,
                    percent: percent.clamp(0.0, 1.0),
                    center: Text('${votes.value}', style: TextStyle(fontSize: 16)),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.orangeAccent,
                    backgroundColor: Colors.grey.shade300,
                  );
                }),
              ],
            ),
            SizedBox(height: 12),
            // زر لايك
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade500,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  onPressed: () async {
                    await voteController.vote(course.id);
                  },
                  icon: Icon(Icons.thumb_up, color: Colors.white),
                  label: Obx(() => Text(
                        '${votes.value}',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
            SizedBox(height: 12),
            // زر التسجيل يظهر فقط إذا الدورة ليست قيد التصويت
            if (!isVoting)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.pinkBeige,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () async {
                  final ok = await courseController.register(course.id);
                  if (ok) {
                    Get.snackbar('نجاح', 'تم التسجيل في الدورة بنجاح',
                        snackPosition: SnackPosition.BOTTOM);
                  } else {
                    Get.snackbar('خطأ', 'فشل التسجيل',
                        snackPosition: SnackPosition.BOTTOM);
                  }
                },
                child: Text('سجل الآن', style: TextStyle(color: Colors.white)),
              ),
          ],
        ),
      ),
    );
  }
}
