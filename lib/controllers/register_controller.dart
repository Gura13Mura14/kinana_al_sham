import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../services/register_service.dart';
import '../widgets/custom_snackbar.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  var isLoading = false.obs;
  var selectedImage = Rx<File?>(null);

  final picker = ImagePicker();
  final RegisterService _service = RegisterService();
  
  

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> register() async {
    isLoading.value = true;
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    final response = await _service.registerUser(
      name: nameController.text,
      email: emailController.text,
      phoneNumber: phoneController.text,
      password: passwordController.text,
      passwordConfirmation: passwordConfirmationController.text,
      profileImage: selectedImage.value,
      fcmToken: fcmToken ?? '',
    );

    isLoading.value = false;

    if (response['statusCode'] == 200 || response['statusCode'] == 201) {
      showCustomSnackbar(
        title: 'نجاح',
        message: response['body']['message'] ?? 'تم التسجيل بنجاح',
        isError: false,
      );
    } else {
      showCustomSnackbar(
        title: 'خطأ',
        message: response['body']['message'] ?? 'فشل التسجيل',
        isError: true,
      );
    }
  }
}
