import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/models/emergency_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyRequestService {
  final String baseUrl = "http://10.0.2.2:8000/api";

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<bool> submitRequest({
    required String requestDetails,
    required String address,
    required String requiredSpecialization,
  }) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/beneficiaries/emergency-requests'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: {
        'request_details': requestDetails,
        'address': address,
        'required_specialization': requiredSpecialization,
      },
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<List<EmergencyRequest>> getMyRequests() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/beneficiaries/emergency/my-requests'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.map((e) => EmergencyRequest.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load requests");
    }
  }

  Future<List<EmergencyRequest>> getRequestsInMyArea() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/emergency-requests/my-area'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.map((e) => EmergencyRequest.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch requests for area");
    }
  }

  Future<bool> acceptRequest(int requestId) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/emergency-requests/$requestId/accept'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    return response.statusCode == 200;
  }
}
