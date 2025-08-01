class ApplicationRequest {
  final int opportunityId;
  final String coverLetter;

  ApplicationRequest({required this.opportunityId, required this.coverLetter});

  Map<String, dynamic> toJson() => {
    'opportunity_id': opportunityId,
    'cover_letter': coverLetter,
  };
}
