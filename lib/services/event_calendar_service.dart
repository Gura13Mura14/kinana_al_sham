import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/models/event_detalis.dart';

class EventCalendarService {
  final String baseUrl = "http://10.0.2.2:8000/api";

  Future<Map<DateTime, List<EventDetails>>> fetchEvents(int month) async {
    final url = Uri.parse("$baseUrl/events/by-month");
    print("📡 [EventCalendarService] POST $url");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"month": month}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        Map<DateTime, List<EventDetails>> mappedEvents = {};

        for (var e in data['events']) {
          EventDetails event = EventDetails.fromJson(e);

          // ناخد فقط تاريخ البداية بدون وقت
          DateTime date = DateTime.parse(event.startDatetime).toLocal();
          DateTime dayKey = DateTime(date.year, date.month, date.day);

          mappedEvents.putIfAbsent(dayKey, () => []);
          mappedEvents[dayKey]!.add(event);
        }

        print("✅ Loaded ${mappedEvents.length} days with events");
        return mappedEvents;
      }
    }

    throw Exception("HTTP ${response.statusCode}: ${response.body}");
  }
}