class SurveyResult {
  final String userId;
  final Map<String, dynamic> answers;
  final DateTime submittedAt;

  SurveyResult({
    required this.userId,
    required this.answers,
    DateTime? submittedAt,
  }) : submittedAt = submittedAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'answers': answers,
        'submittedAt': submittedAt.toIso8601String(),
      };
}
