import 'package:get/get.dart';
import '../models/statistic.dart';
import '../services/statistics_service.dart';

class StatisticsController extends GetxController {
  final StatisticsService _service = StatisticsService();

  var isLoading = false.obs;
  var statistics = <Statistic>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final data = await _service.fetchStatistics();
      statistics.assignAll(data);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
