class VolunteerDetails {
  final String totalHoursVolunteered;

  VolunteerDetails({required this.totalHoursVolunteered});

  factory VolunteerDetails.fromJson(Map<String, dynamic> json) {
    return VolunteerDetails(
      totalHoursVolunteered: json['total_hours_volunteered'] ?? '0',
    );
  }
}

class HonorBoardModel {
  final int id;
  final String name;
  final int rank;
  final VolunteerDetails volunteerDetails;

  HonorBoardModel({
    required this.id,
    required this.name,
    required this.rank,
    required this.volunteerDetails,
  });

  factory HonorBoardModel.fromJson(Map<String, dynamic> json) {
    return HonorBoardModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      rank: json['rank'] ?? 0,
      volunteerDetails: VolunteerDetails.fromJson(json),
    );
  }
}