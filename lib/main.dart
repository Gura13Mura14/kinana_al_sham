// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/routes/app_pages.dart';
import 'package:kinana_al_sham/theme/app_theme.dart';
import 'package:kinana_al_sham/services/storage_service.dart';
import 'package:kinana_al_sham/views/beneficiary_home_view.dart';
import 'package:kinana_al_sham/views/login_view.dart';
import 'package:kinana_al_sham/views/volunteer_home_view.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final loginData = await StorageService.getLoginData();

  final initialRoute = loginData != null ? '/' : '/';
  await initializeDateFormatting('ar', null);

  runApp(
    MyApp(initialRoute: initialRoute, initialArgs: loginData?['user_name'] ?? 'زائر',),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  final String? initialArgs;

  const MyApp({super.key, required this.initialRoute,  this.initialArgs});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
    //  theme: AppTheme.lightTheme,
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      // استخدم onGenerateInitialRoutes لتمرير الـ arguments
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
