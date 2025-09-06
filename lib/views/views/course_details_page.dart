import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/course_controller.dart';
import '../../theme/AppColors.dart';

class CourseDetailsPage extends StatelessWidget {
  final int courseId;
  CourseDetailsPage({super.key, required this.courseId});

  final CourseController controller = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    controller.fetchCourseDetails(courseId);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "تفاصيل الدورة",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(width: 8),
            Icon(Icons.info_outline),
          ],
        ),
        centerTitle: false,
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.pureWhite,
              AppColors.grayWhite,
              AppColors.pinkBeige,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            final course = controller.course.value;
            if (course == null) {
              return Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 🏷️ عنوان الدورة
                  Text(
                    course.title,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  SizedBox(height: 16),

                  // 📝 الوصف داخل Card
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        course.description,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // 📌 تفاصيل الدورة (كل سطر مع أيقونة)
                  _buildDetailItem(Icons.person, "المدرب", course.trainerName),
                  _buildDetailItem(Icons.place, "الموقع", course.location),
                  _buildDetailItem(Icons.date_range, "الفترة",
                      "من ${course.startDate} إلى ${course.endDate}"),
                  _buildDetailItem(Icons.timer, "المدة",
                      "${course.durationHours} ساعة"),

                  SizedBox(height: 40),

                  // 🔘 زر التسجيل
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.pinkBeige,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () async {
                        final result = await controller.register(course.id);
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
                      icon: Icon(Icons.app_registration, color: Colors.white),
                      label: Text(
                        "سجل الآن",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  /// ويدجت لتنسيق عنصر تفاصيل مع أيقونة
  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: AppColors.darkBlue),
        title: Text(
          "$label : $value",
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
