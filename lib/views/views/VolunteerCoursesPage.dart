import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/courses_controller.dart';
import '../../widgets/course_card.dart';

class VolunteerCoursesPage extends StatelessWidget {
  final CoursesController controller = Get.put(CoursesController());

  @override
  Widget build(BuildContext context) {
    controller.fetchCourses();

    return Scaffold(
      appBar: AppBar(title: Text("دورات للتصويت")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.courses.length,
          itemBuilder: (_, index) {
            return CourseCard(course: controller.courses[index]);
          },
        );
      }),
    );
  }
}
