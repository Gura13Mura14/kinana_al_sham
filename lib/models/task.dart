class Task {
  final int id;
  final int roadmapId;
  final String title;
  final String description;
  final int durationInDays;
  int requiredVolunteers; // ✅ أصبح غير نهائي
  bool isChosen;

  Task({
    required this.id,
    required this.roadmapId,
    required this.title,
    required this.description,
    required this.durationInDays,
    required this.requiredVolunteers,
    this.isChosen = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      roadmapId: json['roadmap_id'],
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      durationInDays: json['duration_in_days'] ?? 0,
      requiredVolunteers: json['required_volunteers'] ?? 0,
      isChosen: json['is_chosen'] ?? false,
    );
  }
}