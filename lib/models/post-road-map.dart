class Roadmap {
  final int id;
  final int eventId;
  final int supervisorId;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;

  Roadmap({
    required this.id,
    required this.eventId,
    required this.supervisorId,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Roadmap.fromJson(Map<String, dynamic> json) {
    return Roadmap(
      id: json['id'],
      eventId: json['event_id'],
      supervisorId: json['supervisor_id'],
      title: json['title'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}