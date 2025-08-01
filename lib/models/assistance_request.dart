class AssistanceRequest {
  final int id;
  final int beneficiaryUserId;
  final String assistanceType;
  final String description;
  final String status;
  final String createdAt;

  AssistanceRequest({
    required this.id,
    required this.beneficiaryUserId,
    required this.assistanceType,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  factory AssistanceRequest.fromJson(Map<String, dynamic> json) {
    return AssistanceRequest(
      id: json['id'],
      beneficiaryUserId: json['beneficiary_user_id'],
      assistanceType: json['assistance_type'],
      description: json['description'],
      status: json['status'] ?? 'in_progress',
      createdAt: json['created_at'],
    );
  }
}
