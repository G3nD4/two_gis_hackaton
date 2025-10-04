import 'package:two_gis_hackaton/http/i_http_client.dart';
import 'package:two_gis_hackaton/http/app_http_client.dart';
import '../domain/models/survey_result.dart';
import '../domain/repositories/questionnary_repository.dart';

/// Реализация репозитория, которая использует HTTP клиент для отправки
final class QuestionnaryRepositoryImpl implements QuestionnaryRepository {
  final IHttpClient _httpClient;

  QuestionnaryRepositoryImpl({IHttpClient? httpClient}) : _httpClient = httpClient ?? AppHttpClient();

  @override
  Future<bool> sendSurveyResult(SurveyResult result) async {
    try {
      final response = await _httpClient.post(
        '/v2.0/surveys/results',
        data: result.toJson(),
      );

      // Простейшая проверка: HTTP 2xx -> success
      return response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300;
    } catch (e) {
      // Логирование можно добавить здесь
      return false;
    }
  }
}
