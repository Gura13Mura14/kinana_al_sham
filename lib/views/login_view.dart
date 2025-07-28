import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/widgets/CustomButton.dart';
import 'package:kinana_al_sham/widgets/CustomTextField.dart';
import 'package:kinana_al_sham/widgets/user_type_selector.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'lib/assets/images/logokinanaalsham.png',
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
               
                UserTypeSelector(
                  onChanged: (selected) {
                    controller.userType.value = selected;
                  },
                ),
                const SizedBox(height: 30),
                // ✅ حقل البريد أو رقم الهاتف حسب نوع المستخدم
                Obx(() => CustomTextField(
                      label: controller.userType.value == 'متطوع'
                          ? 'البريد الإلكتروني'
                          : 'رقم الهاتف',
                      controller: controller.emailController,
                      icon: controller.userType.value == 'متطوع'
                          ? Icons.email
                          : Icons.phone,
                    )),
                const SizedBox(height: 30),
                // ✅ كلمة المرور
                CustomTextField(
                  label: 'كلمة المرور',
                  controller: controller.passwordController,
                  icon: Icons.lock,
                  isPassword: true,
                ),
                const SizedBox(height: 45),
                // ✅ زر الدخول أو مؤشر تحميل
                Obx(() => controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        text: 'دخول',
                        onPressed: controller.login,
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
