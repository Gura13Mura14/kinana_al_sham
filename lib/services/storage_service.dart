import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<void> saveLoginData({
    required String token,
    required String userType,
    required int userId, // 👈 أضفنا userId
    String? userName,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setString('user_type', userType);
    await prefs.setInt('user_id', userId); // 👈 نحفظ userId
    await prefs.setString('user_name', userName ?? '');
  }

  static Future<Map<String, dynamic>?> getLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final userType = prefs.getString('user_type');
    final userName = prefs.getString('user_name');
    final userId = prefs.getInt('user_id'); // 👈 استرجاع userId

    if (token != null && userType != null && userId != null) {
      return {
        'token': token,
        'user_type': userType,
        'user_name': userName ?? '',
        'user_id': userId,
      };
    }
    return null;
  }

  static Future<void> clearLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}