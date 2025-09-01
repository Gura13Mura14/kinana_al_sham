class Event {
  final int id;
  final String name;
  final String description;
  final String startDatetime;
  final String endDatetime;
  final String? locationText; // صار nullable
  final String status;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.startDatetime,
    required this.endDatetime,
    this.locationText,
    required this.status,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      startDatetime: json['start_datetime'] ?? '',
      endDatetime: json['end_datetime'] ?? '',
      locationText: json['location_text'], // ممكن يجي null
      status: json['status'] ?? '',
    );
  }
}