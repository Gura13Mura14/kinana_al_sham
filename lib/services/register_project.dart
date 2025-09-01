import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'storage_service.dart';

class VolunteerService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  static Future<void> registerVolunteer(int projectId) async {
    try {
      final loginData = await StorageService.getLoginData();

      if (loginData == null) {
        Get.snackbar("خطأ", "المستخدم غير مسجل الدخول");
        return;
      }

      final token = loginData['token'];

      final url = Uri.parse("$baseUrl/projects/$projectId/register");

      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("نجاح", data['message'] ?? "تم التسجيل في المشروع!");
      } else {
        Get.snackbar("خطأ", data['message'] ?? "حدث خطأ أثناء التسجيل");
      }
    } catch (e) {
      Get.snackbar("خطأ", e.toString());
    }
  }
}