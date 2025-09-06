import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/utils/app_constants.dart';

class WalletService {
  final http.Client _client;
  WalletService({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> fetchBalance(String token) async {
    final res = await _client.get(
      Uri.parse('${AppConstants.baseUrl}/beneficiary/balance'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      return json.decode(res.body);
    } else {
      throw Exception("فشل في جلب الرصيد: ${res.statusCode}");
    }
  }
}
