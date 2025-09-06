import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/storage_service.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  static Future<Map<String, String>> _getHeaders() async {
    final data = await StorageService.getLoginData();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${data?['token']}',
    };
  }

  static Future<dynamic> getRequest(String endpoint) async {
    final headers = await _getHeaders();
    final response = await http.get(Uri.parse("$baseUrl/$endpoint"), headers: headers);
    return json.decode(response.body);
  }

  static Future<dynamic> postRequest(String endpoint, {Map<String, dynamic>? body}) async {
    final headers = await _getHeaders();
    final response = await http.post(Uri.parse("$baseUrl/$endpoint"),
        headers: headers, body: json.encode(body));
    return json.decode(response.body);
  }
}
