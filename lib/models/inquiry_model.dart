class InquiryModel {
  final int id;
  final String subject;
  final String message;
  final String? adminReply;
  final String? repliedAt;
  final String senderName;

  InquiryModel({
    required this.id,
    required this.subject,
    required this.message,
    this.adminReply,
    this.repliedAt,
    required this.senderName,
  });

  factory InquiryModel.fromJson(Map<String, dynamic> json) {
    return InquiryModel(
      id: json['id'],
      subject: json['subject'],
      message: json['message'],
      adminReply: json['admin_reply'],
      repliedAt: json['replied_at'],
      senderName: json['sender']['name'],
    );
  }
}
