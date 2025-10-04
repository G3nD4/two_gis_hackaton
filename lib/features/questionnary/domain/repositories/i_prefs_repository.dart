import 'package:two_gis_hackaton/features/questionnary/domain/models/survey_result.dart';

abstract interface class IPrefsRepository {
  Future<bool> updateUserPreferences(UserPreferences preferences);

  Future<UserPreferences?> getUserPreferences();
}
