import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/courses_controller.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/widgets/course_card.dart';

class CoursesListPage extends StatelessWidget {
  final CoursesController c = Get.put(CoursesController());

  CoursesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // AppBar بدون لون
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'الدورات المقترحة',
            style: TextStyle(color: Colors.black), // يمكنك تغيير اللون حسب التصميم
          ),
          centerTitle: true,
        ),
        // الخلفية مع Gradient
        body: Container(
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
          child: Obx(() {
            if (c.loading.value) {
              return Center(child: CircularProgressIndicator());
            }
            if (c.courses.isEmpty) {
              return Center(child: Text('لا توجد دورات حالياً'));
            }
            return ListView.separated(
              padding: EdgeInsets.all(12),
              itemCount: c.courses.length,
              separatorBuilder: (_, __) => SizedBox(height: 12),
              itemBuilder: (context, i) {
                final course = c.courses[i];
                return CourseCard(course: course);
              },
            );
          }),
        ),
      ),
    );
  }
}
