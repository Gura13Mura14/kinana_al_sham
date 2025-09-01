import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CommentService {
  final String baseUrl = "http://10.0.2.2:8000/api"; // غيّرها حسب السيرفر

  Future<Map<String, dynamic>> addComment({
    required int eventId,
    required int rating,
    String? comment,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth_token");

    final response = await http.post(
      Uri.parse("$baseUrl/events/$eventId/rate"),
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
      body: {"rating": rating.toString(), "comment": comment ?? ""},
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception("فشل إرسال التعليق");
    }
  }
}