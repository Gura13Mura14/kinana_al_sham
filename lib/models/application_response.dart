class Application {
  final int id;
  final int opportunityId;
  final String opportunityTitle;
  final String applicantName;
  final String applicantEmail;
  final String applicationDate;
  final String status;
  final String coverLetter;

  Application({
    required this.id,
    required this.opportunityId,
    required this.opportunityTitle,
    required this.applicantName,
    required this.applicantEmail,
    required this.applicationDate,
    required this.status,
    required this.coverLetter,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'],
      opportunityId: json['opportunity_id'],
      opportunityTitle: json['opportunity_title'],
      applicantName: json['applicant_name'],
      applicantEmail: json['applicant_email'],
      applicationDate: json['application_date'],
      status: json['status'],
      coverLetter: json['cover_letter'],
    );
  }
}
