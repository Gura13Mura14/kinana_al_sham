class VoteResponse {
  final bool success;
  final int totalVotes;
  final double remainingHours;
  final Map<String, dynamic> timeDetails;

  VoteResponse({
    required this.success,
    required this.totalVotes,
    required this.remainingHours,
    required this.timeDetails,
  });

  factory VoteResponse.fromJson(Map<String, dynamic> json) {
    return VoteResponse(
      success: json['success'] ?? false,
      totalVotes: json['total_votes'] ?? 0,
      remainingHours: (json['remaining_hours'] ?? 0).toDouble(),
      timeDetails: json['time_details'] ?? {},
    );
  }
}
