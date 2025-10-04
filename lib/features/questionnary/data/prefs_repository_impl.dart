import 'package:shared_preferences/shared_preferences.dart';
import 'package:two_gis_hackaton/features/questionnary/domain/models/survey_result.dart';
import 'package:two_gis_hackaton/features/questionnary/domain/repositories/i_prefs_repository.dart';

class PrefsRepositoryImpl implements IPrefsRepository {
  @override
  Future<bool> updateUserPreferences(UserPreferences preferences) =>
      SharedPreferences.getInstance().then((prefs) {
        return prefs.setStringList('user_preferences', preferences.selected);
      });

  @override
  Future<UserPreferences?> getUserPreferences() {
    return SharedPreferences.getInstance().then((prefs) {
      final selected = prefs.getStringList('user_preferences');
      if (selected == null) {
        return null;
      }
      return UserPreferences(selected);
    });
  }
}
