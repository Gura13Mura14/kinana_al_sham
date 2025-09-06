class Opportunity {
  final int id;
  final String title;
  final String description;
  final String type;
  final String status;
  final String locationText;
  final DateTime startDate;
  final DateTime endDate;
  final String requirements;
  final bool isRemote;
  final String skills;
  final String category;

  Opportunity({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.locationText,
    required this.startDate,
    required this.endDate,
    required this.requirements,
    required this.isRemote,
    required this.skills,
    required this.category,
  });

  factory Opportunity.fromJson(Map<String, dynamic> json) {
    return Opportunity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      status: json['status'],
      locationText: json['location_text'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      requirements: json['requirements'],
      isRemote: json['is_remote'],
      skills: json['skills'],
      category: json['category'],
    );
  }
}
