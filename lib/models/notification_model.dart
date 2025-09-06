// lib/models/notification_model.dart
class AppNotification {
  final String title;
  final String body;
  final DateTime createdAt;

  AppNotification({
    required this.title,
    required this.body,
    required this.createdAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
