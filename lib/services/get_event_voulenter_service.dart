import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'package:kinana_al_sham/models/event_by_month.dart';
import 'storage_service.dart';

class EventVolunteerService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  static Future<List<Event>> getMyEvents() async {
    try {
      final loginData = await StorageService.getLoginData();
      final token = loginData?['token'] ?? '';

      if (token.isEmpty) {
        throw 'المستخدم غير مسجّل الدخول';
      }

      final response = await http.get(
        Uri.parse('$baseUrl/volunteer/events'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print('Token being sent: $token');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final eventsData = data['data'] ?? [];
        return (eventsData as List)
            .map<Event>((json) => Event.fromJson(json))
            .toList();
      } else {
        final body = jsonDecode(response.body);
        throw body['message'] ?? 'تعذر جلب الفعاليات';
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ: $e');
      return [];
    }
  }
}