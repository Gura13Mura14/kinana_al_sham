import 'package:kinana_al_sham/models/UserRole.dart';
import 'package:kinana_al_sham/models/VolunteerDetails.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String status;
  final String? profilePictureUrl;
  final String? emailVerifiedAt;
  final UserRole role;
  final VolunteerDetails? volunteerDetails;
  final String? createdAt;
  final String? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.status,
    this.profilePictureUrl,
    this.emailVerifiedAt,
    required this.role,
    this.volunteerDetails,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      status: json['status'],
      profilePictureUrl: json['profile_picture_url'],
      emailVerifiedAt: json['email_verified_at'],
      role: UserRole.fromJson(json['role']),
      volunteerDetails: json['volunteer_details'] != null
          ? VolunteerDetails.fromJson(json['volunteer_details'])
          : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
