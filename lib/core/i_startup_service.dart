import 'package:two_gis_hackaton/core/startup/startup_service.dart';

abstract class IStartupService {
  Future<List<SurveyData>> fetchSurveyData();
}
