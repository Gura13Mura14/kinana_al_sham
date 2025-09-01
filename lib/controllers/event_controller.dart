import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:kinana_al_sham/models/event_by_month.dart';
import 'package:kinana_al_sham/services/event_service.dart';

class EventController extends GetxController {
  var events = <Event>[].obs;
  var isLoading = false.obs;

  final EventService _eventService = EventService();

  Future<void> fetchEventsByMonth(int month, int year) async {
    try {
      isLoading(true);
      final result = await _eventService.getEventsByMonth(month, year);
      events.assignAll(result);
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}