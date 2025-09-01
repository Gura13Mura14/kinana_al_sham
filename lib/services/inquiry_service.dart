import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:kinana_al_sham/services/storage_service.dart';
import 'package:kinana_al_sham/utils/app_constants.dart';

class InquiryService {
  static Future<Map<String, dynamic>> submitInquiry({
    required String subject,
    required String message,
  }) async {
    final loginData = await StorageService.getLoginData();
    if (loginData == null) {
      return {'error': 'لم يتم العثور على بيانات الدخول'};
    }

    final token = loginData['token']!;
    final userType = loginData['user_type']!;

    final url = userType == 'متطوع'
        ? '${AppConstants.baseUrl}/inquiries'
        : '${AppConstants.baseUrl}/beneficiaries/inquiries';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: {'subject': subject, 'message': message},
    );

    return {
      'statusCode': response.statusCode,
      'body': json.decode(response.body),
    };
  }

  static Future<Map<String, dynamic>> fetchInquiries() async {
    final loginData = await StorageService.getLoginData();
    if (loginData == null) {
      return {'error': 'لم يتم العثور على بيانات الدخول'};
    }

    final token = loginData['token']!;
    final userType = loginData['user_type']!;

    final url = userType == 'متطوع'
        ? '${AppConstants.baseUrl}/all-inquiries'
        : '${AppConstants.baseUrl}/inquiries';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return {
      'statusCode': response.statusCode,
      'body': json.decode(response.body),
    };
  }
}
