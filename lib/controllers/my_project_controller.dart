import 'package:get/get.dart';
import 'package:kinana_al_sham/services/my_project_service.dart';

class MyProjectsController extends GetxController {
  var isLoading = false.obs;
  var projects = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyProjects();
  }

  Future<void> fetchMyProjects() async {
    try {
      isLoading.value = true;
      final result = await MyProjectsService.getMyProjects();

      // ✅ اطبع الريسبونس كامل بالكونسول
      print("📌 Server Response (My Projects): $result");

      projects.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }
}