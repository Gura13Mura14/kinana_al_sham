import 'package:get/get.dart';
import '../models/course.dart';
import '../services/course_api_service.dart';

class CoursesController extends GetxController {
  var courses = <Course>[].obs;
  var isLoading = false.obs;

  Future<void> fetchCourses() async {
    try {
      isLoading.value = true;
      final data = await ApiService.getRequest("courses");
      if (data['success']) {
        final list = data['data'] is List ? data['data'] : data['data'].values;
        courses.value = list.map<Course>((e) => Course.fromJson(e)).toList();
      }
    } catch (e) {
      print("Error fetching courses: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
