import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_detalis.dart';

class EventDetalisService {
  final String baseUrl = "http://10.0.2.2:8000/api";

  /// جلب الفعاليات حسب التاريخ
  Future<List<EventDetails>> getEventsByDate(String date) async {
    final url = Uri.parse("$baseUrl/events/by-date");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"date": date}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List events = data['events'];
      return events.map((e) => EventDetails.fromJson(e)).toList();
    } else {
      throw Exception("فشل تحميل الفعاليات: ${response.body}");
    }
  }

  /// جلب تفاصيل فعالية حسب الـ ID
  Future<EventDetails> getEventById(int id) async {
    final url = Uri.parse("$baseUrl/events/$id");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return EventDetails.fromJson(data);
    } else {
      throw Exception("فشل تحميل تفاصيل الفعالية: ${response.body}");
    }
  }
}