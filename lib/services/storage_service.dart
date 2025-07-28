import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<void> saveLoginData({
    required String token,
    required String userType,
     String? userName,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setString('user_type', userType);
    await prefs.setString('user_name', userName ?? '');
  }

  static Future<Map<String, String>?> getLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final userType = prefs.getString('user_type');
    final userName = prefs.getString('user_name');

    if (token != null && userType != null && userName != null) {
      return {
        'token': token,
        'user_type': userType,
        'user_name': userName,
      };
    }
    return null;
  }

  static Future<void> clearLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
