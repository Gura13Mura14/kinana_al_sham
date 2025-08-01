import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/widgets/search_and_flter%20.dart';
import 'dart:convert';
import '../models/volunteering_opportunity_model.dart';

class VolunteeringOpportunityController extends GetxController {
  var allOpportunities = <VolunteeringOpportunity>[].obs;
  var filteredOpportunities = <VolunteeringOpportunity>[].obs;
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
        final list = jsonData.map((e) => VolunteeringOpportunity.fromJson(e)).toList();
        allOpportunities.value = list;
        filteredOpportunities.value = list;
      } else {
        Get.snackbar("خطأ", "فشل تحميل البيانات");
      }
    } catch (e) {
      Get.snackbar("خطأ", "خطأ في الاتصال بالخادم");
    } finally {
      isLoading.value = false;
    }
  }

  void filterOpportunities(String searchText, SortOption? sortOption) {
    var list = allOpportunities.where((opp) {
      return opp.title.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    switch (sortOption) {
      case SortOption.nameAZ:
        list.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortOption.nameZA:
        list.sort((a, b) => b.title.compareTo(a.title));
        break;
      case SortOption.dateNewest:
        list.sort((a, b) => b.startDate.compareTo(a.startDate));
        break;
      case SortOption.dateOldest:
        list.sort((a, b) => a.startDate.compareTo(b.startDate));
        break;
      default:
        break;
    }

    filteredOpportunities.value = list;
  }
}
