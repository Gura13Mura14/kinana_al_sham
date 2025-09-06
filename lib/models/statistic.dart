class Statistic {
  final String title;
  final String value;
  final String unit;

  Statistic({
    required this.title,
    required this.value,
    required this.unit,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(
      title: json['العنوان'] ?? '',
      value: json['القيمة'].toString(), 
      unit: json['الوحدة'] ?? '',
    );
  }
}
