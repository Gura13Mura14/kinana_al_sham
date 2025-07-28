import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class ProfileController extends GetxController {
  final user = Rxn<User>();
  final isLoading = false.obs;
  final profilePictureUrl = ''.obs;

  @override
  void onInit() {
    fetchUserProfile();
    super.onInit();
  }

  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      // جلب بيانات المستخدم
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/profile'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        user.value = User.fromJson(data['data']);

        // بعد جلب بيانات المستخدم، نستخدم ID لجلب الصورة
        if (user.value != null) {
          final id = user.value!.id;
          final imageResponse = await http.get(
            Uri.parse('http://10.0.2.2:8000/api/volunteers/$id/profile-picture'),
            headers: {'Authorization': 'Bearer $token'},
          );

          if (imageResponse.statusCode == 200) {
            profilePictureUrl.value = 'http://10.0.2.2:8000/api/volunteers/$id/profile-picture';
          }
        }
      } else {
        print("فشل في جلب البيانات: ${response.body}");
      }
    } catch (e) {
      print("خطأ أثناء جلب الملف الشخصي: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateVolunteerProfile(Map<String, dynamic> updatedData) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.put(
        Uri.parse('http://10.0.2.2:8000/api/volunteer/profile'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(updatedData),
      );

      if (response.statusCode == 200) {
        Get.snackbar("نجاح", "تم تحديث الملف الشخصي بنجاح");
        fetchUserProfile(); // إعادة تحميل البيانات
      } else {
        Get.snackbar("خطأ", "فشل في التحديث: ${response.body}");
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء التحديث");
      print("خطأ أثناء التحديث: $e");
    }
  }
}
