class Beneficiary {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? profilePictureUrl;
  final String status;
  final String civilStatus;
  final String gender;
  final String address;
  final int familyCount;
  final String caseDetails;
  final List<Document> documents;

  Beneficiary({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profilePictureUrl,
    required this.status,
    required this.civilStatus,
    required this.gender,
    required this.address,
    required this.familyCount,
    required this.caseDetails,
    required this.documents,
  });

  factory Beneficiary.fromJson(Map<String, dynamic> json) {
    final details = json['details'] ?? {};
    return Beneficiary(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profilePictureUrl: json['profilePictureUrl'],
      status: json['status'],
      civilStatus: details['civilStatus'] ?? '',
      gender: details['gender'] ?? '',
      address: details['address'] ?? '',
      familyCount: details['familyCount'] ?? 0,
      caseDetails: details['caseDetails'] ?? '',
      documents: (json['documents'] as List)
          .map((doc) => Document.fromJson(doc))
          .toList(),
    );
  }
}

class Document {
  final int id;
  final String fileName;
  final String filePath;
  final String documentType;

  Document({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.documentType,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      fileName: json['file_name'],
      filePath: json['file_path'],
      documentType: json['document_type'],
    );
  }
}
