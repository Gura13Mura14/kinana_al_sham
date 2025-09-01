// lib/models/project.dart
class Project {
  final int id;
  final String projectNumber;
  final String name;
  final String description;
  final String budget;
  final String objective;
  final String status;
  final String startDate;
  final String endDate;
  final String requirements;
  final int maxBeneficiaries;
  final int currentBeneficiaries;
  final String totalRevenue;
  final String totalExpenses;

  Project({
    required this.id,
    required this.projectNumber,
    required this.name,
    required this.description,
    required this.budget,
    required this.objective,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.requirements,
    required this.maxBeneficiaries,
    required this.currentBeneficiaries,
    required this.totalRevenue,
    required this.totalExpenses,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      projectNumber: json['project_number'],
      name: json['name'],
      description: json['description'],
      budget: json['budget'],
      objective: json['objective'],
      status: json['status'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      requirements: json['requirements'],
      maxBeneficiaries: json['max_beneficiaries'] ?? 0,
      currentBeneficiaries: json['current_beneficiaries'] ?? 0,
      totalRevenue: json['total_revenue'] ?? "0",
      totalExpenses: json['total_expenses'] ?? "0",
    );
  }
}