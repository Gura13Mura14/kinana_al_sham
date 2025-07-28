import 'dart:convert';

class VolunteerDetails {
  final String? skills;
  final String? interests;
  final Map<String, String>? availabilitySchedule;
  final int? totalPoints;
  final String? totalHoursVolunteered;

  VolunteerDetails({
    this.skills,
    this.interests,
    this.availabilitySchedule,
    this.totalPoints,
    this.totalHoursVolunteered,
  });

  factory VolunteerDetails.fromJson(Map<String, dynamic> json) {
    return VolunteerDetails(
      skills: json['skills'],
      interests: json['interests'],
      availabilitySchedule: json['availability_schedule'] != null
          ? Map<String, String>.from(jsonDecode(json['availability_schedule']))
          : null,
      totalPoints: json['total_points'],
      totalHoursVolunteered: json['total_hours_volunteered'],
    );
  }
}
