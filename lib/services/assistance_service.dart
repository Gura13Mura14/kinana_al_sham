import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/models/assistance_request.dart';
import 'dart:convert';
import 'package:kinana_al_sham/services/storage_service.dart';


class AssistanceService {
  static const String baseUrl = 'http://10.0.2.2:8000/api/beneficiaries/assistance-requests';

  static Future<bool> requestAssistance(String type, String description) async {
    final loginData = await StorageService.getLoginData();
    if (loginData == null) return false;

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer ${loginData['token']}',
        'Accept': 'application/json',
      },
      body: {
        'assistance_type': type,
        'description': description,
      },
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<List<AssistanceRequest>> getMyRequests() async {
    final loginData = await StorageService.getLoginData();
    if (loginData == null) return [];

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer ${loginData['token']}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      return (jsonData['data'] as List)
          .map((e) => AssistanceRequest.fromJson(e))
          .toList();
    }
    return [];
  }
}
