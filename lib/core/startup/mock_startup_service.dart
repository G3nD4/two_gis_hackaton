import 'package:two_gis_hackaton/core/i_startup_service.dart';
import 'package:two_gis_hackaton/core/startup/startup_service.dart';

class MockStartupService implements IStartupService {
  @override
  Future<List<SurveyData>> fetchSurveyData() async {
    await Future.delayed(const Duration(seconds: 3));
    return Future.value([SurveyData(key: 'Restaurants', value: 'restaurants')]);
  }
}
