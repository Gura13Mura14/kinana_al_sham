import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/register_controller.dart';
import 'package:kinana_al_sham/widgets/CustomButton.dart';
import 'package:kinana_al_sham/widgets/CustomTextField.dart';
import 'package:kinana_al_sham/widgets/user_type_selector.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

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
                const SizedBox(height: 40),
                Image.asset(
                    'lib/assets/images/logokinana.jpg',
                      height: 100,
                       width: 100,
                       ),
                const SizedBox(height: 20),

                const SizedBox(height: 20),

                const Text(
                  'إنشاء حساب',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),
                 UserTypeSelector(
                   onChanged: (selected) {
                     print('تم اختيار: $selected');
                        },
                      ),
                const SizedBox(height: 20),

                Obx(() {
                  final imageFile = controller.selectedImage.value;
                  return GestureDetector(
                    onTap: controller.pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: imageFile != null ? FileImage(imageFile) : null,
                      child: imageFile == null
                          ? const Icon(Icons.camera_alt, size: 30, color: Colors.grey)
                          : null,
                    ),
                  );
                }),

                const SizedBox(height: 30),
                CustomTextField(
                  label: 'الاسم الكامل',
                  controller: controller.nameController,
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  label: 'البريد الإلكتروني',
                  controller: controller.emailController,
                  icon: Icons.email,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  label: 'رقم الهاتف',
                  controller: controller.phoneController,
                  icon: Icons.phone,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  label: 'كلمة المرور',
                  controller: controller.passwordController,
                  isPassword: true,
                  icon: Icons.lock,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  label: 'تأكيد كلمة المرور',
                  controller: controller.passwordconfirmationController,
                  isPassword: true,
                  icon: Icons.password,
                ),
                const SizedBox(height: 30),

                Obx(() => controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        text: 'تسجيل',
                        onPressed: controller.register,
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
