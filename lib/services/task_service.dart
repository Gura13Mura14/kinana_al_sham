import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/models/task.dart';
import 'package:kinana_al_sham/services/storage_service.dart';

class TaskService {
  static const String baseUrl = "http://10.0.2.2:8000/api/tasks";

  // إضافة Task جديد
  static Future<Task> addTask({
    required int roadmapId,
    required String title,
    required String description,
    required int durationInDays,
    required int requiredVolunteers,
  }) async {
    final loginData = await StorageService.getLoginData();
    if (loginData == null) throw Exception("User not logged in");
    final token = loginData['token'];

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: json.encode({
        "roadmap_id": roadmapId,
        "title": title,
        "description": description,
        "duration_in_days": durationInDays,
        "required_volunteers": requiredVolunteers,
      }),
    );

    print("🔵 Status: ${response.statusCode}");
    print("📩 Response: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Task.fromJson(json.decode(response.body));
    } else {
      throw Exception("فشل في إضافة التاسك: ${response.body}");
    }
  }

  // دالة لاختيار Task من قبل المتطوع
  static Future<void> chooseTask(int taskId) async {
    final loginData = await StorageService.getLoginData();
    if (loginData == null) throw Exception("User not logged in");
    final token = loginData['token'];

    final response = await http.post(
      Uri.parse("$baseUrl/$taskId/choose"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    print("🔵 Choose Task Status: ${response.statusCode}");
    print("📩 Response: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("فشل في اختيار التاسك: ${response.body}");
    }
  }
}