// lib/controllers/project_controller.dart
import 'package:get/get.dart';

import 'package:kinana_al_sham/models/project_model.dart';
import 'package:kinana_al_sham/services/project_service.dart';

class ProjectController extends GetxController {
  final ProjectService _service = ProjectService();

  var isLoading = false.obs;
  var projects = <Project>[].obs;

  Future<void> fetchProjects() async {
    try {
      isLoading.value = true;
      projects.value = await _service.fetchProjects();
    } catch (e) {
      print("❌ Error fetching projects: $e");
    } finally {
      isLoading.value = false;
    }
  }
}