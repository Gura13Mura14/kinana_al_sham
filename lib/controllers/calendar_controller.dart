import 'package:get/get.dart';
import 'package:kinana_al_sham/models/event_detalis.dart';
import 'package:kinana_al_sham/services/event_calendar_service.dart';

class CalendarController extends GetxController {
  final EventCalendarService _service = EventCalendarService();

  var isLoading = false.obs;
  var events = <DateTime, List<EventDetails>>{}.obs;
  var selectedEvents = <EventDetails>[].obs;
  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;

  Future<void> fetchEvents(int month) async {
    try {
      isLoading.value = true;
      events.value = await _service.fetchEvents(month);
    } catch (e) {
      print("❌ Error fetching events: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onDaySelected(DateTime day) {
    selectedDay.value = DateTime(day.year, day.month, day.day);
    focusedDay.value = day;

    selectedEvents.value = events[selectedDay.value] ?? [];
    print("📅 Selected day: $selectedDay → ${selectedEvents.length} events");
  }
}