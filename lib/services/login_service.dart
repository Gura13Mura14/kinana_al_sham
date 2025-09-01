import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/services/storage_service.dart';
import 'package:kinana_al_sham/utils/app_constants.dart';

class LoginService {
  static Future<Map<String, dynamic>> login({
    required String userType,
    required String phoneOrEmail,
    required String password,
  }) async {
    final url = userType == 'متطوع'
        ? '${AppConstants.baseUrl}/login'
        : '${AppConstants.baseUrl}/beneficiaries/login';

    final credentials = userType == 'متطوع'
        ? {'email': phoneOrEmail, 'password': password}
        : {'phone_number': phoneOrEmail, 'password': password};

    final response = await http.post(
      Uri.parse(url),
      headers: {'Accept': 'application/json'},
      body: credentials,
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      final token = data['token'];
      final name = data['user']['name'];

      await StorageService.saveLoginData(
        token: token,
        userType: userType,
        userName: name,
      );
    }

    return {'status': response.statusCode, 'data': data};
  }
}
