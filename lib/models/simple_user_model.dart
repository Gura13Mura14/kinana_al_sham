import 'package:kinana_al_sham/models/VolunteerDetails.dart';

class SimpleUser {
  final int id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String role;
  final VolunteerDetails? volunteerDetails;
  final String? profilePictureUrl;

  SimpleUser({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.role = 'Volunteer',
    this.volunteerDetails,
    this.profilePictureUrl,
  });


  SimpleUser copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? role,
    VolunteerDetails? volunteerDetails,
    String? profilePictureUrl,
  }) {
    return SimpleUser(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      volunteerDetails: volunteerDetails ?? this.volunteerDetails,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }

  factory SimpleUser.fromJson(Map<String, dynamic> json) {
    return SimpleUser(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'],
      role: json['role'] ?? 'Volunteer',
      profilePictureUrl: json['profile_picture_url'],
      volunteerDetails: json['volunteer_details'] != null
          ? VolunteerDetails.fromJson(json['volunteer_details'])
          : null,
    );
  }
}
