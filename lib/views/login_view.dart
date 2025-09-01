import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/widgets/CustomButton.dart';
import 'package:kinana_al_sham/widgets/CustomTextField.dart';
import 'package:kinana_al_sham/widgets/user_type_selector.dart';
import '../controllers/login_controller.dart';
import '../widgets/responsive_sizes.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: r.wp(5)),
                  child: Column(
                    children: [
                      SizedBox(height: r.hp(5)),
              
                      /// 🔹 اللوغو بعرض نسبي وحواف Padding
                      Center(
                        child: Image.asset(
                          'lib/assets/images/logoo.jpg',
                          height: r.hp(30),
                          width: r.wp(40),
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: r.hp(3)),
              
                      /// 🔹 عنوان الصفحة
                      Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          color: AppColors.darkBlue,
                          fontSize: r.sp(24),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: r.hp(3)),
              
                      /// 🔹 اختيار نوع المستخدم
                      UserTypeSelector(
                        onChanged: (selected) {
                          controller.userType.value = selected;
                        },
                      ),
                      SizedBox(height: r.hp(3)),
              
                      /// 🔹 البريد أو رقم الهاتف
                      Obx(() => CustomTextField(
                            label: controller.userType.value == 'متطوع'
                                ? 'البريد الإلكتروني'
                                : 'رقم الهاتف',
                            controller: controller.emailController,
                            icon: controller.userType.value == 'متطوع'
                                ? Icons.email
                                : Icons.phone,
                          )),
                      SizedBox(height: r.hp(2.5)),
              
                      /// 🔹 كلمة المرور
                      CustomTextField(
                        label: 'كلمة المرور',
                        controller: controller.passwordController,
                        icon: Icons.lock,
                        isPassword: true,
                      ),
                      SizedBox(height: r.hp(4)),
              
                      /// 🔹 زر الدخول أو مؤشر التحميل
                      Obx(() => controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : CustomButton(
                              text: 'دخول',
                              color: AppColors.grayWhite,
                              width: r.wp(50),
                              onPressed: controller.login,
                            )),
                      SizedBox(height: r.hp(3)),
              
                      /// 🔹 زر إنشاء حساب للمتطوعين فقط
                      Obx(() => controller.userType.value == 'متطوع'
                          ? TextButton(
                              onPressed: () => Get.toNamed('/register'),
                              child: Text(
                                'متطوع جديد؟ إنشاء حساب',
                                style: TextStyle(
                                  color: AppColors.darkBlue,
                                  fontSize: r.sp(14),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : const SizedBox()),
              
                      SizedBox(height: r.hp(5)), // 🔹 فراغ من أسفل
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
