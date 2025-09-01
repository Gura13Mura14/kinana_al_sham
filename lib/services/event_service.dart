import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/models/event_by_month.dart';

class EventService {
  final String baseUrl = "http://10.0.2.2:8000/api";

  Future<List<Event>> getEventsByMonth(int month, int year) async {
    final url = Uri.parse("$baseUrl/events/by-month");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"month": month, "year": year}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List events = data['events'];
      return events.map((e) => Event.fromJson(e)).toList();
    } else {
      throw Exception("فشل تحميل الفعاليات: ${response.body}");
    }
  }
}