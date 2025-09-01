import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/services/storage_service.dart';

class MyProjectsService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  static Future<List<dynamic>> getMyProjects() async {
    final loginData = await StorageService.getLoginData();
    if (loginData == null) return [];

    final token = loginData['token'];
    final url = Uri.parse("$baseUrl/volunteer/projects");

    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    );

    // اطبع الـ Status Code + Response كامل
    print("📌 Status Code: ${response.statusCode}");
    print("📌 Server Response: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        return data['data'] ?? []; // ✅ تعديل هنا من 'projects' إلى 'data'
      }
    }

    return [];
  }
}