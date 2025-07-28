import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/volunteering_opportunity_model.dart';

class VolunteeringOpportunityController extends GetxController {
  var opportunities = <VolunteeringOpportunity>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchOpportunities();
    super.onInit();
  }

  void fetchOpportunities() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/opportunities/volunteering'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'] as List;
        opportunities.value = jsonData.map((e) => VolunteeringOpportunity.fromJson(e)).toList();
      } else {
        Get.snackbar("خطأ", "فشل تحميل البيانات");
      }
    } catch (e) {
      Get.snackbar("خطأ", "خطأ في الاتصال بالخادم");
    } finally {
      isLoading.value = false;
    }
  }
}
