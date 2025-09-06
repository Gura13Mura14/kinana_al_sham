import 'package:get/get.dart';
import 'package:kinana_al_sham/services/WalletService.dart';
import 'package:kinana_al_sham/services/storage_service.dart';

class WalletController extends GetxController {
  final WalletService service;
  WalletController(this.service);

  final isLoading = false.obs;
  final balance = "0.00".obs;
  final userName = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchWallet();
  }

  Future<void> fetchWallet() async {
    isLoading.value = true;
    try {
      final loginData = await StorageService.getLoginData();
      if (loginData == null) throw Exception("No saved login");

      final token = loginData['token']!;
      final data = await service.fetchBalance(token);

      // update values
      userName.value = data['name'] ?? '';
      balance.value = data['current_balance'] ?? "0.00";
    } catch (e) {
      Get.snackbar("خطأ", "تعذر جلب رصيد المحفظة");
    } finally {
      isLoading.value = false;
    }
  }
}
