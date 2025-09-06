class Course {
  final int id;
  final String title;
  final String description;
  final String trainerName;
  final String startDate;
  final String endDate;
  final int durationHours;
  final String location;
  final String targetAudience;
  final int currentVolunteers;
  final int maxVolunteers;
  final List votes;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.trainerName,
    required this.startDate,
    required this.endDate,
    required this.durationHours,
    required this.location,
    required this.targetAudience,
    required this.currentVolunteers,
    required this.maxVolunteers,
    required this.votes,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      trainerName: json['trainer_name'] ?? json['trainer'],
      startDate: json['start_date'] ?? json['schedule']?['start_date'],
      endDate: json['end_date'] ?? json['schedule']?['end_date'],
      durationHours: json['duration_hours'] ?? json['schedule']?['duration_hours'],
      location: json['location'],
      targetAudience: json['target_audience'] ?? '',
      currentVolunteers: json['current_volunteers'] ?? 0,
      maxVolunteers: json['max_volunteers'] ?? 0,
      votes: json['votes'] ?? [],
    );
  }
}
