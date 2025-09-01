import 'dart:convert';
import 'package:http/http.dart' as http;
import 'storage_service.dart';

class RegisterEventService {
  final String baseUrl = "http://10.0.2.2:8000/api";

  Future<bool> registerVolunteer(int eventId) async {
    try {
      final loginData = await StorageService.getLoginData();
      // print("DEBUG loginData: $loginData");

      if (loginData == null || loginData['user_type'] != 'متطوع') {
        throw 'عفواً، التسجيل متاح فقط للمتطوعين.';
      }

      final token = loginData['token'];
      final url = Uri.parse('$baseUrl/events/$eventId/register');

      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      //print('Server Response: ${response.body}');
      final body = json.decode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true; // ✅ أي كود نجاح (200–299) يعتبر نجاح
      } else {
        throw body['message'] ?? 'حدث خطأ أثناء التسجيل';
      }
    } catch (e) {
      rethrow;
    }
  }
}