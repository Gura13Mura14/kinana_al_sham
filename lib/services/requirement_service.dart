// lib/services/requirement_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'storage_service.dart';

class RequirementService {
  final String baseUrl = "http://10.0.2.2:8000/api";

  Future<List<String>> fetchRequirements(int eventId) async {
    try {
      final loginData = await StorageService.getLoginData();
      if (loginData == null) {
        throw 'المستخدم غير مسجل الدخول';
      }

      final token = loginData['token'];
      final url = Uri.parse('$baseUrl/projects/$eventId/requirements');

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final body = json.decode(response.body);

      if (response.statusCode == 200 && body['success'] == true) {
        List<dynamic> reqs = body['data']['requirements'] ?? [];
        return reqs.map((e) => e.toString()).toList();
      } else {
        throw body['message'] ?? 'فشل في جلب المتطلبات';
      }
    } catch (e) {
      rethrow;
    }
  }
}