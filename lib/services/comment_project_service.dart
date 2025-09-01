import 'dart:convert';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'storage_service.dart';

class RatingService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  static Future<bool> submitRating({
    required int projectId,
    required int rating,
    String? comment,
  }) async {
    try {
      final loginData = await StorageService.getLoginData();
      if (loginData == null) {
        Get.snackbar(
          "خطأ",
          "المستخدم غير مسجل الدخول",
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }

      final token = loginData['token'];
      final url = Uri.parse("$baseUrl/projects/$projectId/ratings");

      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"rating": rating, "comment": comment}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // ✅ Snackbar أكيد يظهر
        Future.delayed(Duration.zero, () {
          Get.snackbar(
            "نجاح ✅",
            data['message'] ?? "تم تسجيل التقييم بنجاح",
            snackPosition: SnackPosition.TOP,
            backgroundColor: const Color.fromARGB(255, 55, 99, 124),
            colorText: const Color(0xFFFFFFFF),
            duration: const Duration(seconds: 2),
          );
        });
        return true;
      } else {
        Future.delayed(Duration.zero, () {
          Get.snackbar(
            "خطأ ❌",
            data['message'] ?? "فشل في تسجيل التقييم",
            snackPosition: SnackPosition.TOP,
            backgroundColor: const Color(0xFFF44336),
            colorText: const Color(0xFFFFFFFF),
          );
        });
        return false;
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        Get.snackbar(
          "خطأ",
          e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFF44336),
          colorText: const Color(0xFFFFFFFF),
        );
      });
      return false;
    }
  }
}