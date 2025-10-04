// Mock repository for questionnary feature. No HTTP client required here.
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
