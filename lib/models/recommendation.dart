class Recommendation {
  final int id;
  final String title;
  final String type;
  final String category;
  final String startDate;
  final String endDate;
  final bool isRemote;
  final int score;

  Recommendation({
    required this.id,
    required this.title,
    required this.type,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.isRemote,
    required this.score,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    final opportunity = json['opportunity'];
    return Recommendation(
      id: opportunity['id'],
      title: opportunity['title'],
      type: opportunity['type'],
      category: opportunity['category'],
      startDate: opportunity['start_date'],
      endDate: opportunity['end_date'],
      isRemote: opportunity['is_remote'],
      score: json['score'],
    );
  }
}
