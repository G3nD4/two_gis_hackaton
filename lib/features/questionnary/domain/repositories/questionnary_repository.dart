import '../models/survey_result.dart';

/// Интерфейс репозитория для работы с результатами опроса
abstract class QuestionnaryRepository {
  /// Отправляет результат опроса на сервер
  /// Возвращает true при успешной отправке
  Future<bool> sendSurveyResult(SurveyResult result);
}
