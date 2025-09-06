// services/recommendation_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/services/storage_service.dart';
import 'package:kinana_al_sham/utils/app_constants.dart';

class RecommendationService {
  Future<List<dynamic>> fetchRecommendations() async {
    final loginData = await StorageService.getLoginData();
    if (loginData == null) throw Exception("User not logged in");

    final token = loginData['token'];

    final response = await http.get(
      Uri.parse("${AppConstants.baseUrl}/volunteers/recommendations"),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data; // بيرجع List من التوصيات
    } else {
      throw Exception("Failed to load recommendations");
    }
  }
}
