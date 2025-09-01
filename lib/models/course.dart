class Course {
  final int id;
  final String title;
  final String description;
  final String trainerName;
  final DateTime? startDate;
  final DateTime? endDate;
  final int durationHours;
  final String location;
  final String targetAudience;
  final int isAnnounced;
  final List<dynamic> votes; 

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.trainerName,
    this.startDate,
    this.endDate,
    required this.durationHours,
    required this.location,
    required this.targetAudience,
    required this.isAnnounced,
    required this.votes,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      trainerName: json['trainer_name'] ?? json['trainer'] ?? '',
      startDate: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      durationHours: json['duration_hours'] ?? (json['schedule']?['duration_hours'] ?? 0),
      location: json['location'] ?? '',
      targetAudience: json['target_audience'] ?? '',
      isAnnounced: json['is_announced'] ?? 0,
      votes: json['votes'] ?? [],
    );
  }

  int get votesCount => votes.length;
}
