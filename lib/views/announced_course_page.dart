import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/course_controller.dart';
import '../../widgets/course_card.dart';
import '../../theme/AppColors.dart';

class AnnouncedCoursePage extends StatelessWidget {
  final CourseController controller = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    controller.fetchAnnouncedCourse();

    return Scaffold(
      extendBodyBehindAppBar: true, // ✅ يخلي الخلفية تطلع وراء الـ AppBar
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent, // ✅ شفاف حتى يبين الـ gradient
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "الدورة المعلنة",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Icon(Icons.menu_book),
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
        child: SafeArea( // ✅ يحمي من تغطية الـ notch/status bar
          child: Obx(() {
            if (controller.course.value == null) {
              return Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              padding: EdgeInsets.all(12),
              child: CourseCard(
                course: controller.course.value!,
                showVote: false,
                showRegister: true,
              ),
            );
          }),
        ),
      ),
    );
  }
}
