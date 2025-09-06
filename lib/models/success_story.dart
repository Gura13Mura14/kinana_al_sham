class SuccessStory {
  final int id;
  final String title;
  final String content;
  final String? imageUrl;
  final String? status;
  final String? submissionDate;
  final String? submittedByName;
  final String? submittedByPicture;

  SuccessStory({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    this.status,
    this.submissionDate,
    this.submittedByName,
    this.submittedByPicture,
  });

  factory SuccessStory.fromJson(Map<String, dynamic> json) {
    return SuccessStory(
      id: json['id'],
      title: json['title'] ?? '',
      content: json['content'] ?? json['story_content'] ?? '',
      imageUrl: json['image_url'],
      status: json['status'] ?? 'pending_approval',
      submissionDate: json['submission_date'],
      submittedByName: json['submitted_by']?['name'],
      submittedByPicture: json['submitted_by']?['profile_picture_url'],
    );
  }
}
