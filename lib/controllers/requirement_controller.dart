// lib/controllers/requirement_controller.dart
import 'package:get/get.dart';
import '../services/requirement_service.dart';

class RequirementController extends GetxController {
  final RequirementService _service = RequirementService();

  var requirements = <String>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> loadRequirements(int eventId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      requirements.value = await _service.fetchRequirements(eventId);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}