import 'package:two_gis_hackaton/http/i_http_client.dart';
import 'package:two_gis_hackaton/http/app_http_client.dart';
import '../domain/models/survey_result.dart';
import '../domain/repositories/questionnary_repository.dart';

/// Реализация репозитория, которая использует HTTP клиент для отправки
final class QuestionnaryRepositoryMock implements QuestionnaryRepository {
  @override
  Future<bool> sendSurveyResult(SurveyResult result) async {
    await Future.delayed(const Duration(seconds: 3));
    return true;
  }
}
