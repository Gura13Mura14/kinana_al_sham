class SuccessStory {
  final int id;
  final String title;
  final String content;
  final String imageUrl;
  final String status;

  SuccessStory({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.status,
  });

  factory SuccessStory.fromJson(Map<String, dynamic> json) {
    return SuccessStory(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'],
      status: json['status'] ?? 'pending_approval',
    );
  }
}
