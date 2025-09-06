import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kinana_al_sham/models/honor_board.dart';

class HonorBoardController extends GetxController {
  List<HonorBoardModel> topVolunteers = [];
  var isLoading = true.obs;

  Map<String, dynamic>? volunteerOfWeek;

  Future<void> fetchHonorBoard() async {
    try {
      isLoading(true);
      final url = Uri.parse("http://10.0.2.2:8000/api/honor-board");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['data'] != null) {
          topVolunteers = List<HonorBoardModel>.from(
            data['data'].map((item) => HonorBoardModel.fromJson(item)),
          );
        }
      }
    } catch (e) {
      print("Error fetching honor board: $e");
    } finally {
      isLoading(false);
      update();
    }
  }

  Future<void> fetchVolunteerOfWeek() async {
    try {
      final url = Uri.parse("http://10.0.2.2:8000/api/volunteer-of-week");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        volunteerOfWeek = data;
      }
    } catch (e) {
      print("Error fetching volunteer of week: $e");
    } finally {
      update();
    }
  }

  Map<String, dynamic>? volunteerOfMonth;

  Future<void> fetchVolunteerOfMonth() async {
    try {
      final url = Uri.parse("http://10.0.2.2:8000/api/volunteer-of-month");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        volunteerOfMonth = data;
      }
    } catch (e) {
      print("Error fetching volunteer of month: $e");
    } finally {
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchHonorBoard();
    fetchVolunteerOfWeek();
    fetchVolunteerOfMonth();
  }
}