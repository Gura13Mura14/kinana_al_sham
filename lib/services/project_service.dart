// lib/services/project_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/models/project_model.dart';

class ProjectService {
  final String baseUrl = "http://10.0.2.2:8000/api";

  Future<List<Project>> fetchProjects() async {
    final url = Uri.parse("$baseUrl/show/projects");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        final List<dynamic> projectsJson = data['data'];
        return projectsJson.map((e) => Project.fromJson(e)).toList();
      }
    }

    throw Exception("Failed to load projects: ${response.body}");
  }
}