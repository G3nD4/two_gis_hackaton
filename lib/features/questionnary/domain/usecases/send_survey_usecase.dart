import '../models/survey_result.dart';
import '../repositories/questionnary_repository.dart';

/// UseCase: отправка результата опроса
final class SendSurveyUseCase {
  final QuestionnaryRepository repository;

  SendSurveyUseCase(this.repository);

  /// Выполняет отправку результата и возвращает success/failure
  Future<bool> execute(SurveyResult result) =>
      repository.sendSurveyResult(result);
}
