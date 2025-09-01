import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course.dart';
import '../models/vote_response.dart';
import 'storage_service.dart';

class ApiService {
  final String _baseUrl = 'http://10.0.2.2:8000';

  Future<Map<String, String>> _headers() async {
    final data = await StorageService.getLoginData();
    final token = data?['token'] ?? '';
    return {
      'Content-Type': 'application/json',
      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

 Future<List<Course>> getCourses() async {
  final headers = await _headers();
  final response = await http.get(Uri.parse('$_baseUrl/api/courses'), headers: headers);

  if (response.statusCode == 200) {
    final decoded = jsonDecode(response.body);
    if (decoded['success'] == true) {
      final Map<String, dynamic> data = decoded['data'];
      final List raw = data.values.toList(); 
      return raw.map((e) => Course.fromJson(e)).toList();
    }
  }
  return [];
}


  Future<Course?> getCourseById(int id) async {
    final headers = await _headers();
    final response = await http.get(Uri.parse('$_baseUrl/api/courses/$id'), headers: headers);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded['success'] == true) {
        return Course.fromJson(decoded['data']);
      }
    }
    return null;
  }

  Future<VoteResponse> postVote(int courseId) async {
    final headers = await _headers();
    final response = await http.post(
      Uri.parse('$_baseUrl/api/$courseId/vote'),
      headers: headers,
    );

    final decoded = jsonDecode(response.body);
    return VoteResponse.fromJson(decoded);
  }

  Future<Map<String, dynamic>> postRegister(int courseId) async {
    final headers = await _headers();
    final response = await http.post(
      Uri.parse('$_baseUrl/api/courses/$courseId/register'),
      headers: headers,
    );

    return jsonDecode(response.body);
  }

  Future<Course?> getAnnouncedCourse() async {
    final headers = await _headers();
    final response = await http.get(Uri.parse('$_baseUrl/api/volunteer/news'), headers: headers);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded['success'] == true) {
        return Course.fromJson(decoded['data']);
      }
    }
    return null;
  }
}
