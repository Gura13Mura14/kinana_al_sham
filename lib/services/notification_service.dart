import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'storage_service.dart'; 

class NotificationService extends GetxService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<NotificationService> init() async {
    await _fcm.requestPermission();

    String? token = await _fcm.getToken();
    print(" FCM Token: $token");

    if (token != null) {
      await sendTokenToServer(token);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("إشعار Foreground: ${message.notification?.title}");


      Get.snackbar(
        message.notification?.title ?? "إشعار",
        message.notification?.body ?? "",
        snackPosition: SnackPosition.TOP,
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("المستخدم فتح التطبيق من الإشعار");
    });

    return this; 
  }

  Future<void> sendTokenToServer(String token) async {
    final loginData = await StorageService.getLoginData();
    if (loginData == null) return;

    String userType = loginData['user_type']!;
    String url;

    if (userType == "متطوع") {
      url = "http://10.0.2.2:8000/api/register";
    } else if (userType == "مستفيد") {
      url = "http://10.0.2.2:8000/api/beneficiaries/login";
    } else {
      print(" نوع مستخدم غير معروف: $userType");
      return;
    }

    final response = await http.post(
      Uri.parse(url),
      body: {'token': token},
      headers: {
        'Authorization': 'Bearer ${loginData['token']}',
      },
    );

    print("📨 Server Response: ${response.body}");
  }
}
