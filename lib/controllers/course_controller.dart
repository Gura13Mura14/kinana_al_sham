import 'package:get/get.dart';
import 'package:kinana_al_sham/services/course_api_service.dart';
import '../models/course.dart';


class CourseController extends GetxController {
  final ApiService api = ApiService();

  var course = Rxn<Course>();
  var loading = false.obs;

  Future<void> loadCourse(int id) async {
    try {
      loading.value = true;
      course.value = await api.getCourseById(id);
    } finally {
      loading.value = false;
    }
  }

  Future<bool> register(int id) async {
    final res = await api.postRegister(id);
    return res['success'] == true;
  }
}
