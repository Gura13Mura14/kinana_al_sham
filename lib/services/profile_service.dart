import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/models/simple_user_model.dart';
import 'package:kinana_al_sham/utils/app_constants.dart';


class ProfileService {
final http.Client _client;
ProfileService({http.Client? client}) : _client = client ?? http.Client();


Future<SimpleUser> fetchProfile(String token) async {
final res = await _client.get(
Uri.parse('${AppConstants.baseUrl}/profile'),
headers: {
'Accept': 'application/json',
'Authorization': 'Bearer $token',
},
);
if (res.statusCode == 200 || res.statusCode == 201) {
final data = json.decode(res.body);
return SimpleUser.fromJson(data['data']);
}
throw Exception('Failed to fetch profile: ${res.statusCode}');
}


Future<String?> fetchProfilePicture(int userId) async {
final url = Uri.parse('${AppConstants.baseUrl}/volunteers/$userId/profile-picture');
final res = await _client.get(url);
if (res.statusCode == 200) {
return url.toString();
}
return null; // لا توجد صورة
}


Future<bool> updateVolunteerProfile(String token, Map<String, dynamic> updated) async {
final res = await _client.put(
Uri.parse('${AppConstants.baseUrl}/volunteer/profile'),
headers: {
'Accept': 'application/json',
'Authorization': 'Bearer $token',
'Content-Type': 'application/json',
},
body: json.encode(updated),
);
return res.statusCode == 200 || res.statusCode == 201;
}
}