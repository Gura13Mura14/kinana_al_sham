import 'package:get/get.dart';
import 'package:kinana_al_sham/services/course_api_service.dart';
import '../models/course.dart';

class CourseController extends GetxController {
  var course = Rxn<Course>();

  Future<void> fetchCourseDetails(int id) async {
    final data = await ApiService.getRequest("courses/$id");
    if (data['success']) {
      course.value = Course.fromJson(data['data']);
    }
  }

Future<Map<String, dynamic>> register(int id) async {
  final data = await ApiService.postRequest("courses/$id/register");
  return {
    "success": data['success'] ?? false,
    "message": data['message'] ?? "حدث خطأ أثناء التسجيل"
  };
}


  Future<void> fetchAnnouncedCourse() async {
    final data = await ApiService.getRequest("volunteer/news");
    if (data['success']) {
      course.value = Course.fromJson(data['data']);
    }
  }
}
