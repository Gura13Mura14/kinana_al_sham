import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kinana_al_sham/services/storage_service.dart';
import '../views/volunteer_home_view.dart';

class LoginController extends GetxController {
  final TextEditingController emailController =
      TextEditingController(); // يستخدم لرقم الهاتف حاليًا
  final TextEditingController passwordController = TextEditingController();
  final isLoading = false.obs;
  final userType = 'مستفيد'.obs;

  void login() async {
    final phone = emailController.text.trim();
    final password = passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      Get.snackbar('خطأ', 'يرجى إدخال كل الحقول');
      return;
    }

    isLoading.value = true;

    final url =
        userType.value == 'متطوع'
            ? 'http://10.0.2.2:8000/api/login'
            : 'http://10.0.2.2:8000/api/beneficiaries/login';

    final credentials =
        userType.value == 'متطوع'
            ? {'email': phone, 'password': password}
            : {'phone_number': phone, 'password': password};

    try {
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
          userType: userType.value,
          userName: name,
        );

        if (userType.value == 'متطوع') {
          Get.offAll(() => VolunteerHomeView(), arguments: name);
        } else {
          Get.offAllNamed('/home2', arguments: name);
        }
      } else {
        Get.snackbar('فشل الدخول', data['message'] ?? 'حدث خطأ');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ غير متوقع');
    } finally {
      isLoading.value = false;
    }
  }
}
