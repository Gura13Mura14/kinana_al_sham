class VolunteerDetails {
  final int userId;
  final String skills;
  final String interests;
  final Map<String, String> availabilitySchedule;
  final String emergencyContactName;
  final String emergencyContactPhone;
  final String dateJoinedFromForm;
  final String? volunteeringTypePreference;
  final String address;
  final String createdAt;
  final String updatedAt;

  VolunteerDetails({
    required this.userId,
    required this.skills,
    required this.interests,
    required this.availabilitySchedule,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
    required this.dateJoinedFromForm,
    this.volunteeringTypePreference,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  VolunteerDetails copyWith({
    String? skills,
    String? interests,
    String? emergencyContactName,
    String? emergencyContactPhone,
    String? address,
  }) {
    return VolunteerDetails(
      userId: userId,
      skills: skills ?? this.skills,
      interests: interests ?? this.interests,
      availabilitySchedule: availabilitySchedule,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactPhone: emergencyContactPhone ?? this.emergencyContactPhone,
      dateJoinedFromForm: dateJoinedFromForm,
      volunteeringTypePreference: volunteeringTypePreference,
      address: address ?? this.address,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory VolunteerDetails.fromJson(Map<String, dynamic> json) {
    return VolunteerDetails(
      userId: json['user_id'],
      skills: json['skills'] ?? '',
      interests: json['interests'] ?? '',
      availabilitySchedule: Map<String, String>.from(json['availability_schedule'] ?? {}),
      emergencyContactName: json['emergency_contact_name'] ?? '',
      emergencyContactPhone: json['emergency_contact_phone'] ?? '',
      dateJoinedFromForm: json['date_joined_from_form'] ?? '',
      volunteeringTypePreference: json['volunteering_type_preference'],
      address: json['address'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
