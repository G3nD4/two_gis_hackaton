import 'package:two_gis_hackaton/features/questionnary/domain/models/ranking_model.dart';

import '../models/survey_result.dart';

/// Интерфейс репозитория для работы с результатами опроса
abstract class IPolygonRepository {
  /// Отправляет результат опроса на сервер
  /// Возвращает true при успешной отправке
  Future<RankingModel?> getPolygons(UserPreferences result, int page);

  Stream<RankingModel?> watchPolygons(UserPreferences result);
}
