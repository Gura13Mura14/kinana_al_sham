import 'package:kinana_al_sham/models/VolunteerDetails.dart';

class SimpleUser {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String role;
  final VolunteerDetails? volunteerDetails;
  final String? profilePictureUrl;

  SimpleUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
    this.volunteerDetails,
    this.profilePictureUrl,
  });

  factory SimpleUser.fromJson(Map<String, dynamic> json) {
    return SimpleUser(
      id: json['volunteer_details']?['user_id'] ?? 0,
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'] ?? '',
      role: json['role'] ?? 'Volunteer',
      volunteerDetails:
          json['volunteer_details'] != null
              ? VolunteerDetails.fromJson(json['volunteer_details'])
              : null,

      profilePictureUrl: null,
    );
  }

  SimpleUser copyWith({String? profilePictureUrl}) {
    return SimpleUser(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      role: role,
      volunteerDetails: volunteerDetails,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }
}
