class Certificate {
  final String volunteerName;
  final String eventName;
  final String issuedAt;

  Certificate({
    required this.volunteerName,
    required this.eventName,
    required this.issuedAt,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      volunteerName: json['user']['name'],
      eventName: json['event']['name'],
      issuedAt: json['certificate_issued_at'],
    );
  }
}