class UserPreferences {
  final List<String> selected;

  UserPreferences(this.selected);

  Map<String, dynamic> toJson() =>
      Map<String, dynamic>.fromIterable(selected, value: (it) => 1);
}
