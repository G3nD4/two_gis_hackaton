import 'package:two_gis_hackaton/http/i_http_client.dart';

abstract class IStartupService {
  Future<List<String>> fetchSurveyData();
}
