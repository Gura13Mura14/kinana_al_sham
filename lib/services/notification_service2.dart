import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/utils/app_constants.dart';
import '../models/notification_model.dart';
import '../services/storage_service.dart';

class NotificationService2 {
  Future<List<AppNotification>> fetchNotifications() async {
    final url = Uri.parse('${AppConstants.baseUrl}/admin/my-notifications');
    final loginData = await StorageService.getLoginData();

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${loginData?['token']}',
      },
    );

    print("📨 Notifications API: ${response.statusCode} => ${response.body}");

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body['status'] == 'success') {
        final List data = body['notifications'];
        return data.map((e) => AppNotification.fromJson(e)).toList();
      } else {
        throw Exception('الاستعلام لم يرجع بيانات صحيحة');
      }
    } else {
      throw Exception('فشل الاتصال بالسيرفر: ${response.statusCode}');
    }
  }
}
