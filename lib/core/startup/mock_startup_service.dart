import 'package:two_gis_hackaton/core/i_startup_service.dart';

class MockStartupService implements IStartupService {
  @override
  Future<List<String>> fetchSurveyData() async {
    await Future.delayed(const Duration(seconds: 3));
    return Future.value(['Survey 1', 'Survey 2', 'Survey 3']);
  }
}
