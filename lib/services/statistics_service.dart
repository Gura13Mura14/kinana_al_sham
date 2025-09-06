import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/utils/app_constants.dart';
import '../models/statistic.dart';

class StatisticsService {
  Future<List<Statistic>> fetchStatistics() async {
    final url = Uri.parse('${AppConstants.baseUrl}/statistics');

    final response = await http.get(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);

      if (body['success'] == true) {
        print(body);
        final List data = body['detail'];
        return data.map((e) => Statistic.fromJson(e)).toList();
      } else {
        print(body);
        throw Exception('الاستعلام لم يرجع بيانات صحيحة');
      }
    } else {
      
      throw Exception('فشل الاتصال بالسيرفر: ${response.statusCode}');
    }
  }
}
