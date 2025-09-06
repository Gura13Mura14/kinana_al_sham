// controllers/recommendation_controller.dart
import 'package:get/get.dart';
import 'package:kinana_al_sham/services/recommendation_service.dart';

class RecommendationController extends GetxController {
  final RecommendationService service;
  RecommendationController(this.service);

  var recommendations = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecommendations();
  }

  void fetchRecommendations() async {
    try {
      isLoading.value = true;
      final data = await service.fetchRecommendations();
      recommendations.value = data;
    } catch (e) {
      print("Error fetching recommendations: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
