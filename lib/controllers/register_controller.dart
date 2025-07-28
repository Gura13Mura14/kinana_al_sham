import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordconfirmationController = TextEditingController();

  var isLoading = false.obs;
  var selectedImage = Rx<File?>(null);

  final picker = ImagePicker();

  /// اختيار صورة من الجهاز
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      print("تم اختيار الصورة: ${pickedFile.path}");
    } else {
      print("لم يتم اختيار أي صورة");
    }
  }

  Future<void> register() async {
    isLoading.value = true;

    final url = Uri.parse('http://10.0.2.2:8000/api/register');

    try {
      var request = http.MultipartRequest('POST', url);

      request.fields['name'] = nameController.text;
      request.fields['email'] = emailController.text;
      request.fields['phone_number'] = phoneController.text;
      request.fields['password'] = passwordController.text;
      request.fields['password_confirmation'] = passwordController.text;

      if (selectedImage.value != null) {
        var imageFile = await http.MultipartFile.fromPath(
          'profile_picture', // تأكد من اسم الحقل في Laravel
          selectedImage.value!.path,
          filename: basename(selectedImage.value!.path),
        );
        request.files.add(imageFile);
      }

      request.headers['Accept'] = 'application/json';

      var response = await request.send();
      isLoading.value = false;

      var responseBody = await response.stream.bytesToString();
      print("Status Code: ${response.statusCode}");
      print("Response Body: $responseBody");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(responseBody);
        Get.snackbar("نجاح", data["message"]);
      } else {
        final data = json.decode(responseBody);
        Get.snackbar("خطأ", data["message"] ?? "فشل التسجيل");
      }
    } catch (e) {
      isLoading.value = false;
      print("خطأ في الاتصال أو الرفع: $e");
      Get.snackbar("خطأ", "حدث خطأ أثناء الاتصال بالسيرفر");
    }
  }
}
