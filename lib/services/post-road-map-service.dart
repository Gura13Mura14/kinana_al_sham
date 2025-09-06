// services/roadmap_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/models/post-road-map.dart';
import 'package:kinana_al_sham/services/storage_service.dart';

class RoadmapService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  // إضافة Roadmap جديد
  static Future<Roadmap?> addRoadmap({
    required int eventId,
    required String title,
  }) async {
    final loginData = await StorageService.getLoginData();
    if (loginData == null) throw Exception("User not logged in");
    final token = loginData['token'];

    final response = await http.post(
      Uri.parse("$baseUrl/roadmaps"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"event_id": eventId, "title": title}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Roadmap.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to add roadmap: ${response.body}");
    }
  }

  // جلب Roadmap واحد حسب eventId
  static Future<Roadmap?> fetchByEventId(int eventId) async {
    final loginData = await StorageService.getLoginData();
    if (loginData == null) throw Exception("User not logged in");
    final token = loginData['token'];

    final response = await http.get(
      Uri.parse("$baseUrl/events/$eventId/roadmaps"),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      if (data.isEmpty) return null;
      return Roadmap.fromJson(data.first);
    } else {
      throw Exception(
        "Failed to fetch roadmap for event $eventId: ${response.body}",
      );
    }
  }

  // جلب كل Roadmaps
  static Future<List<Roadmap>> fetchRoadmaps() async {
    final loginData = await StorageService.getLoginData();
    if (loginData == null) throw Exception("User not logged in");
    final token = loginData['token'];

    final response = await http.get(
      Uri.parse("$baseUrl/roadmaps"),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Roadmap.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load roadmaps: ${response.body}");
    }
  }
}