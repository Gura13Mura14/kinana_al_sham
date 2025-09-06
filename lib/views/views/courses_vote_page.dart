import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/courses_controller.dart';
import '../../widgets/course_card.dart';
import '../../theme/AppColors.dart';

class CoursesVotePage extends StatelessWidget {
  final CoursesController controller = Get.put(CoursesController());

  @override
  Widget build(BuildContext context) {
    controller.fetchCourses();

    return Scaffold(
      extendBodyBehindAppBar: true, // ✅ حتى يظهر الـ gradient خلف الـ AppBar
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "الدورات للتصويت",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Icon(Icons.how_to_vote),
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
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            if (controller.courses.isEmpty) {
              return Center(
                child: Text(
                  "لا توجد دورات حالياً",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: controller.courses.length,
              itemBuilder: (_, index) {
                return CourseCard(
                  course: controller.courses[index],
                  showVote: true,
                  showRegister: false,
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
