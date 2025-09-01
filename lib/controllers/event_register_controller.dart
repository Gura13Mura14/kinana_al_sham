import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/services/event_register_service.dart';

class RegisterEventController {
  final RegisterEventService service;

  RegisterEventController({required this.service});

  Future<void> register(int eventId) async {
    try {
      final success = await service.registerVolunteer(eventId);
      if (success) {
        Get.snackbar(
          'نجاح',
          'تم التسجيل في الفعالية بنجاح!',
          snackPosition: SnackPosition.TOP, // بتقدر تغيرها لـ TOP
          backgroundColor: Color(0xFFbfc7ca),
          colorText: Colors.blueGrey,
        );
      }
    } catch (e) {
      Get.snackbar(
        'خطأ',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Color(0xFFbfc7ca),
        colorText: Colors.blueGrey,
      );
    }
  }
}