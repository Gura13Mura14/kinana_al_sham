import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../models/success_story.dart';
import '../services/success_story_service.dart';
import '../services/storage_service.dart';

class SuccessStoryController extends GetxController {
  final stories = <SuccessStory>[].obs;
  final isSubmitting = false.obs;
  final filter = 'all'.obs;

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  File? selectedImage;

  final _service = SuccessStoryService();

  Future<void> loadPendingStories() async {
    try {
      final result = await _service.fetchPendingStories();
      stories.assignAll(result);
    } catch (e) {
      Get.snackbar("خطأ", "تعذر تحميل القصص");
      print("Error fetching pending stories: $e");
    }
  }

  List<SuccessStory> get filteredStories {
    if (filter.value == 'all') return stories;
    return stories.where((s) => s.status == filter.value).toList();
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) selectedImage = File(picked.path);
    update();
  }

  Future<void> submitStory() async {
    if (titleController.text.isEmpty || contentController.text.isEmpty || selectedImage == null) {
      Get.snackbar("تنبيه", "يرجى تعبئة كافة الحقول واختيار صورة");
      return;
    }

    isSubmitting.value = true;

    try {
      final result = await _service.submitStory(
        title: titleController.text,
        content: contentController.text,
        image: selectedImage!,
      );

      isSubmitting.value = false;

      if (result['statusCode'] == 200 || result['statusCode'] == 201) {
        Get.snackbar("تم الإرسال", "تم إرسال القصة بنجاح");
        Get.back();
      } else {
        Get.snackbar("فشل", "حدث خطأ أثناء الإرسال\n${result['body']}");
      }
    } catch (e) {
      isSubmitting.value = false;
      Get.snackbar("خطأ", "حدث استثناء: $e");
      print("Exception: $e");
    }
  }
  Future<void> loadApprovedStories() async {
  try {
    final result = await _service.fetchApprovedStories();
    stories.assignAll(result);
  } catch (e) {
    Get.snackbar("خطأ", "تعذر تحميل قصص النجاح");
    print("Error fetching approved stories: $e");
  }
}


  String translateStatus(String status) {
    switch (status) {
      case 'pending_approval':
        return 'قيد الموافقة';
      case 'approved':
        return 'تمت الموافقة';
      default:
        return 'غير معروف';
    }
  }
}
