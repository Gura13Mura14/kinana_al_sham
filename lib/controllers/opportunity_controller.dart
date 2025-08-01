import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/widgets/search_and_flter%20.dart';
import 'dart:convert';
import '../models/opportunity_model.dart';

class OpportunityController extends GetxController {
  var opportunities = <Opportunity>[].obs;         // All opportunities
  var filteredOpportunities = <Opportunity>[].obs; // Filtered list for display
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchOpportunities();
    super.onInit();
  }

  void fetchOpportunities() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/opportunities/jobs'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'] as List;
        opportunities.value = jsonData.map((e) => Opportunity.fromJson(e)).toList();
        filteredOpportunities.value = List.from(opportunities); // Initialize filtered
      } else {
        Get.snackbar('خطأ', 'فشل تحميل البيانات');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء الاتصال بالسيرفر');
    } finally {
      isLoading.value = false;
    }
  }

  void filterOpportunities(String searchText, SortOption? sortOption) {
    List<Opportunity> result = List.from(opportunities);

    // Search
    if (searchText.isNotEmpty) {
      result = result
          .where((opp) => opp.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }

    // Sort
    if (sortOption != null) {
      switch (sortOption) {
        case SortOption.nameAZ:
          result.sort((a, b) => a.title.compareTo(b.title));
          break;
        case SortOption.nameZA:
          result.sort((a, b) => b.title.compareTo(a.title));
          break;
        case SortOption.dateNewest:
          result.sort((a, b) => b.startDate.compareTo(a.startDate));
          break;
        case SortOption.dateOldest:
          result.sort((a, b) => a.startDate.compareTo(b.startDate));
          break;
      }
    }

    filteredOpportunities.value = result;
  }
}
