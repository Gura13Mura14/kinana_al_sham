
import 'package:kinana_al_sham/models/simple_user_model.dart';


class LoginResponse {
  final String message;
  final String token;
  final SimpleUser user;

  LoginResponse({
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      token: json['token'],
      user: SimpleUser.fromJson(json['user']),
    );
  }
}
