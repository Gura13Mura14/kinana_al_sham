// lib/controllers/notification_controller.dart
import 'package:get/get.dart';
import '../models/notification_model.dart';
import '../services/notification_service2.dart';

class NotificationController extends GetxController {
  final NotificationService2 _service = NotificationService2();

  var isLoading = false.obs;
  var notifications = <AppNotification>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchNotifications();
    super.onInit();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      final data = await _service.fetchNotifications();
      notifications.assignAll(data);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
