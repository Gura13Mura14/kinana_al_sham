import 'package:get/get.dart';
import 'package:kinana_al_sham/models/assistance_request.dart';
import 'package:kinana_al_sham/services/assistance_service.dart';


class AssistanceController extends GetxController {
  var requests = <AssistanceRequest>[].obs;
  var isLoading = false.obs;

  Future<void> submitRequest(String type, String description) async {
    isLoading.value = true;
    final success = await AssistanceService.requestAssistance(type, description);
    isLoading.value = false;
    if (success) {
      Get.snackbar('تم', 'تم إرسال طلب المساعدة بنجاح');
      await fetchMyRequests(); 
    } else {
      Get.snackbar('خطأ', 'فشل إرسال الطلب');
    }
  }

  Future<void> fetchMyRequests() async {
    isLoading.value = true;
    requests.value = await AssistanceService.getMyRequests();
    isLoading.value = false;
  }
}
