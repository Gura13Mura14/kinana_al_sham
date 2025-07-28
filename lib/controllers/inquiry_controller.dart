import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/models/inquiry_model.dart';
import 'package:kinana_al_sham/services/storage_service.dart';

class InquiryController extends GetxController {
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  void submitInquiry() async {
  final subject = subjectController.text.trim();
  final message = messageController.text.trim();

  if (subject.isEmpty || message.isEmpty) {
    Get.snackbar('خطأ', 'يرجى تعبئة جميع الحقول');
    return;
  }

  final loginData = await StorageService.getLoginData();
  if (loginData == null) {
    Get.snackbar('خطأ', 'لم يتم العثور على بيانات الدخول');
    return;
  }

  final token = loginData['token']!;
  final userType = loginData['user_type']!;

  // 🔁 URL حسب نوع المستخدم
  final url = userType == 'متطوع'
      ? 'http://10.0.2.2:8000/api/inquiries'
      : 'http://10.0.2.2:8000/api/beneficiaries/inquiries';

  final headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final body = {
    'subject': subject,
    'message': message,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    final responseData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar('نجاح', responseData['message'] ?? 'تم إرسال الاستفسار بنجاح');
      clearFields();
    } else {
      Get.snackbar('خطأ', responseData['message'] ?? 'فشل إرسال الاستفسار');
    }
  } catch (e) {
    Get.snackbar('خطأ', 'حدث خطأ أثناء إرسال الاستفسار');
  }
}

void clearFields() {
  subjectController.clear();
  messageController.clear();
}


RxList<InquiryModel> inquiries = <InquiryModel>[].obs;

Future<void> fetchInquiries() async {
  final loginData = await StorageService.getLoginData();
  if (loginData == null) return;

  final token = loginData['token']!;
  final userType = loginData['user_type']!;
  final url = userType == 'متطوع'
      ? 'http://10.0.2.2:8000/api/all-inquiries'
      : 'http://10.0.2.2:8000/api/beneficiaries/inquiries';

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body)['data'];
      inquiries.value =
          List<InquiryModel>.from(data.map((e) => InquiryModel.fromJson(e)));
    } else {
      Get.snackbar('خطأ', 'فشل تحميل الاستفسارات');
    }
  } catch (e) {
    Get.snackbar('خطأ', 'حدث خطأ أثناء تحميل الاستفسارات');
  }
}
}