import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/services/login_service.dart';
import 'package:kinana_al_sham/views/volunteer_home_view.dart';
import 'package:kinana_al_sham/widgets/custom_snackbar.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final isLoading = false.obs;
  final userType = 'مستفيد'.obs;

  void login() async {
    final phoneOrEmail = emailController.text.trim();
    final password = passwordController.text.trim();

    if (phoneOrEmail.isEmpty || password.isEmpty) {
      showCustomSnackbar(
        title: 'خطأ',
        message: 'يرجى إدخال كل الحقول',
        isError: true,
      );
      return;
    }

    isLoading.value = true;

    try {
      final result = await LoginService.login(
        userType: userType.value,
        phoneOrEmail: phoneOrEmail,
        password: password,
      );

      final status = result['status'] as int;
      final data = result['data'];

      if (status == 200) {
        final name = data['user']['name'];
        if (userType.value == 'متطوع') {
          Get.offAll(() => VolunteerHomeView(), arguments: name);
        } else {
          Get.offAllNamed('/home2', arguments: name);
        }
      } else {
        showCustomSnackbar(
          title: 'فشل الدخول',
          message: data['message'] ?? 'حدث خطأ',
          isError: true,
        );
      }
    } catch (e) {
      showCustomSnackbar(
        title: 'خطأ',
        message: 'حدث خطأ غير متوقع',
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
