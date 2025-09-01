import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/inquiry_model.dart';
import '../services/inquiry_service.dart';
import '../widgets/custom_snackbar.dart';

class InquiryController extends GetxController {
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  RxList<InquiryModel> inquiries = <InquiryModel>[].obs;
  var isLoading = false.obs;

  Future<void> submitInquiry() async {
    final subject = subjectController.text.trim();
    final message = messageController.text.trim();

    if (subject.isEmpty || message.isEmpty) {
      showCustomSnackbar(title: 'خطأ', message: 'يرجى تعبئة جميع الحقول', isError: true);
      return;
    }

    isLoading.value = true;
    final result = await InquiryService.submitInquiry(subject: subject, message: message);
    isLoading.value = false;

    if (result['statusCode'] == 200 || result['statusCode'] == 201) {
      showCustomSnackbar(title: 'نجاح', message: result['body']['message'] ?? 'تم إرسال الاستفسار');
      clearFields();
      fetchInquiries();
    } else {
      showCustomSnackbar(title: 'خطأ', message: result['body']['message'] ?? 'فشل الإرسال', isError: true);
    }
  }

  Future<void> fetchInquiries() async {
    isLoading.value = true;
    final result = await InquiryService.fetchInquiries();
    isLoading.value = false;

    if (result['statusCode'] == 200) {
      final data = result['body']['data'];
      inquiries.value = List<InquiryModel>.from(data.map((e) => InquiryModel.fromJson(e)));
    } else {
      showCustomSnackbar(title: 'خطأ', message: 'فشل تحميل الاستفسارات', isError: true);
    }
  }

  void clearFields() {
    subjectController.clear();
    messageController.clear();
  }
}
