import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kinana_al_sham/utils/app_constants.dart';


class RegisterService {
  Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required String passwordConfirmation,
    File? profileImage,
    required String fcmToken,
  }) async {
    final url = Uri.parse('${AppConstants.baseUrl}/register');
    var request = http.MultipartRequest('POST', url);

    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['phone_number'] = phoneNumber;
    request.fields['password'] = password;
    request.fields['password_confirmation'] = password;
    request.fields['fcm_token'] = fcmToken;


    if (profileImage != null) {
      var imageFile = await http.MultipartFile.fromPath(
        'profile_picture',
        profileImage.path,
      );
      request.files.add(imageFile);
    }

    request.headers['Accept'] = 'application/json';

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();
    return {
      'statusCode': response.statusCode,
      'body': json.decode(responseBody),
    };
  }
}
