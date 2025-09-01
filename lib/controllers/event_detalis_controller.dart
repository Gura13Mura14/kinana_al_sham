import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/services/event_datelis_service.dart';
import 'package:kinana_al_sham/services/storage_service.dart';
import '../models/event_detalis.dart';


class EventDetalisController extends GetxController {
  var eventsByDate = <EventDetails>[].obs;
  var selectedEvent = Rxn<EventDetails>(); // فعالية واحدة للتفاصيل
  var isLoading = false.obs;

  final EventDetalisService _eventService = EventDetalisService();

  /// جلب الفعاليات حسب التاريخ
  Future<void> fetchEventsByDate(String date) async {
    try {
      isLoading(true);
      final result = await _eventService.getEventsByDate(date);
      eventsByDate.assignAll(result);
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  /// جلب فعالية واحدة حسب الـ ID
  Future<void> fetchEventById(int id) async {
    try {
      isLoading(true);
      final result = await _eventService.getEventById(id);
      selectedEvent.value = result;
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}