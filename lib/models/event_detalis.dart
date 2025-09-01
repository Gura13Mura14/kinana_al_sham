class EventType {
  final int id;
  final String name;
  final String description;

  EventType({required this.id, required this.name, required this.description});

  factory EventType.fromJson(Map<String, dynamic> json) {
    return EventType(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name'], email: json['email']);
  }
}

class EventDetails {
  final int id;
  final String name;
  final String description;
  final String startDatetime;
  final String endDatetime;
  final String locationText;
  final String status;
  final double? latitude;
  final double? longitude;
  final int? maxParticipants;
  final EventType? eventType;
  final User? organizer;
  final User? supervisor;
  final List<User> volunteers;

  EventDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.startDatetime,
    required this.endDatetime,
    required this.locationText,
    required this.status,
    this.latitude,
    this.longitude,
    this.maxParticipants,
    this.eventType,
    this.organizer,
    this.supervisor,
    this.volunteers = const [],
  });

  factory EventDetails.fromJson(Map<String, dynamic> json) {
    return EventDetails(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      startDatetime: json['start_datetime'],
      endDatetime: json['end_datetime'],
      locationText: json['location_text'],
      status: json['status'],
      latitude:
          json['latitude'] != null
              ? double.tryParse(json['latitude'].toString())
              : null,
      longitude:
          json['longitude'] != null
              ? double.tryParse(json['longitude'].toString())
              : null,
      maxParticipants: json['max_participants'],
      eventType:
          json['event_type'] != null
              ? EventType.fromJson(json['event_type'])
              : null,
      organizer:
          json['organizer'] != null ? User.fromJson(json['organizer']) : null,
      supervisor:
          json['supervisor'] != null ? User.fromJson(json['supervisor']) : null,
      volunteers:
          json['volunteers'] != null
              ? (json['volunteers'] as List)
                  .map((v) => User.fromJson(v))
                  .toList()
              : [],
    );
  }
}