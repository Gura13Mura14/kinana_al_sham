import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../services/storage_service.dart';
import '../models/post-road-map.dart';

class RoadmapController extends GetxController {
  var isLoading = false.obs;
  var roadmaps = <Roadmap>[].obs;

  /// جلب Roadmap حسب eventId
  Future<void> fetchRoadmapByEvent(int eventId) async {
    try {
      isLoading.value = true;

      final loginData = await StorageService.getLoginData();
      final token = loginData?['token'];

      if (token == null) {
        Get.snackbar("خطأ", "التوكن غير موجود، يرجى تسجيل الدخول مجدداً");
        return;
      }

      // جلب Roadmap المرتبط بالفعالية
      final response = await http.get(
        Uri.parse("http://10.0.2.2:8000/api/events/$eventId/roadmaps"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        if (data.isEmpty) {
          Get.snackbar("تنبيه", "لا يوجد Roadmap مرتبط بهذه الفعالية");
          roadmaps.clear();
          return;
        }

        // نستخدم أول Roadmap مرتبط بالفعالية
        roadmaps.value = data.map((e) => Roadmap.fromJson(e)).toList();
      } else {
        Get.snackbar("خطأ", "فشل في تحميل الـ Roadmap: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("خطأ", "حصل استثناء: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// جلب Roadmap محدد حسب roadmapId
  Roadmap? getRoadmapById(int roadmapId) {
    try {
      return roadmaps.firstWhere((r) => r.id == roadmapId);
    } catch (e) {
      return null;
    }
  }
}