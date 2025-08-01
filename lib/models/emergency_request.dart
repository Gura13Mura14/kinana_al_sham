class EmergencyRequest {
  final int id;
  final int beneficiaryUserId;
  final String requestDetails;
  final String address;
  final String requiredSpecialization;
  final String status;
  final int? assignedVolunteerUserId;
  final String? resolutionDetails;
  final String createdAt;
  final String updatedAt;
  final Beneficiary? beneficiary;

  EmergencyRequest(
    {
      
    required this.id,
    required this.beneficiaryUserId,
    required this.requestDetails,
    required this.address,
    required this.requiredSpecialization,
    required this.status,
    this.assignedVolunteerUserId,
    this.resolutionDetails,
    required this.createdAt,
    required this.updatedAt,
    this.beneficiary,
  });
DateTime get createdAtDate => DateTime.parse(createdAt);

  factory EmergencyRequest.fromJson(Map<String, dynamic> json) {
    return EmergencyRequest(
      id: json['id'],
      beneficiaryUserId: json['beneficiary_user_id'],
      requestDetails: json['request_details'],
      address: json['address'],
      requiredSpecialization: json['required_specialization'],
      status: json['status'],
      assignedVolunteerUserId: json['assigned_volunteer_user_id'],
      resolutionDetails: json['resolution_details'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      beneficiary: json['beneficiary'] != null
          ? Beneficiary.fromJson(json['beneficiary'])
          : null,
          
    );
  }
}

class Beneficiary {
  final int id;
  final String name;

  Beneficiary({required this.id, required this.name});

  factory Beneficiary.fromJson(Map<String, dynamic> json) {
    return Beneficiary(
      id: json['id'],
      name: json['name'],
    );
  }
}
