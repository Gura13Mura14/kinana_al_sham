import 'package:get/get.dart';
import 'package:kinana_al_sham/models/emergency_request.dart';
import '../services/emergency_request_service.dart';

class EmergencyRequestController extends GetxController {
  final EmergencyRequestService _service = EmergencyRequestService();

  var isLoading = false.obs;
  var myRequests = <EmergencyRequest>[].obs;
  var areaRequests = <EmergencyRequest>[].obs;

  Future<void> submitEmergencyRequest({
    required String details,
    required String address,
    required String specialization,
  }) async {
    isLoading.value = true;
    final success = await _service.submitRequest(
      requestDetails: details,
      address: address,
      requiredSpecialization: specialization,
    );
    isLoading.value = false;

    if (success) {
      Get.snackbar('تم', 'تم إرسال طلب الطوارئ بنجاح');
      await fetchMyRequests();
    } else {
      Get.snackbar('خطأ', 'فشل في إرسال الطلب');
    }
  }

  Future<void> fetchMyRequests() async {
    try {
      isLoading.value = true;
      myRequests.value = await _service.getMyRequests();
    } catch (e) {
      Get.snackbar('خطأ', 'فشل في تحميل طلباتك');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchRequestsInMyArea() async {
    try {
      isLoading.value = true;
      areaRequests.value = await _service.getRequestsInMyArea();
    } catch (e) {
      Get.snackbar('خطأ', 'فشل في تحميل طلبات منطقتك');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> acceptRequest(int requestId) async {
    isLoading.value = true;
    final success = await _service.acceptRequest(requestId);
    isLoading.value = false;

    if (success) {
      Get.snackbar('تم', 'تم قبول الطلب بنجاح');
      await fetchRequestsInMyArea();
    } else {
      Get.snackbar('خطأ', 'فشل في قبول الطلب');
    }
  }
}
