import 'dart:developer';

import 'package:two_gis_hackaton/features/questionnary/domain/models/polygon_model.dart';
import 'package:two_gis_hackaton/features/questionnary/domain/models/ranking_model.dart';
import 'package:two_gis_hackaton/http/i_http_client.dart';
import 'package:two_gis_hackaton/http/app_http_client.dart';
import '../domain/models/survey_result.dart';
import '../domain/repositories/polygon_repository.dart';

/// Реализация репозитория, которая использует HTTP клиент для отправки
final class PolygonRepositoryImpl implements IPolygonRepository {
  final IHttpClient _httpClient;

  PolygonRepositoryImpl({IHttpClient? httpClient})
    : _httpClient = httpClient ?? AppHttpClient();

  @override
  Future<RankingModel?> getPolygons(UserPreferences result, int page) async {
    final response = await _httpClient.post(
      '/rank_polygons/',
      data: result.toJson(),
      queryParameters: {'page': page, 'size': 100},
    );
    print(response.data);
    if (response.statusCode != 200 || response.data == null) {
      return null;
    }

    return RankingModel.fromJson(response.data);
  }
}
