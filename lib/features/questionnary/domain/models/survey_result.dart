class SurveyResult {
  final List<String> selected;

  SurveyResult(this.selected);

  Map<String, dynamic> toJson() => {'selected': selected};
}
