import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/routes/app_pages.dart';
import 'package:kinana_al_sham/services/notification_service.dart';
import 'package:kinana_al_sham/services/storage_service.dart';
import 'package:kinana_al_sham/views/beneficiary_home_view.dart';
import 'package:kinana_al_sham/views/login_view.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(" إشعار في الخلفية: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  String? fcmToken = await FirebaseMessaging.instance.getToken();
  print(" FCM Token: $fcmToken");
  await Get.putAsync(() => NotificationService().init());

  final loginData = await StorageService.getLoginData();
  final initialRoute = loginData != null ? '/' : '/';
  await initializeDateFormatting('ar', null);

  runApp(
    MyApp(
      initialRoute: initialRoute,
      initialArgs: loginData?['user_name'] ?? 'زائر',
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  final String? initialArgs;

  const MyApp({super.key, required this.initialRoute, this.initialArgs});

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(" إشعار Foreground: ${message.notification?.title}");
      Get.snackbar(
        message.notification?.title ?? "إشعار",
        message.notification?.body ?? "",
        snackPosition: SnackPosition.TOP,
      );
    });

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      
      getPages: AppPages.routes,
      onGenerateInitialRoutes: (route) {
        return [
          GetPageRoute(
            page: () {
              if (initialRoute == '/home') {
                return BeneficiaryHomeView();
              } else {
                return const LoginView();
              }
            },
            settings: RouteSettings(name: initialRoute),
          ),
        ];
      },
    );
  }
}
