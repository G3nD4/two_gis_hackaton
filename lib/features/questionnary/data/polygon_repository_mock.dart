// Mock repository for questionnary feature. No HTTP client required here.
import 'package:dgis_mobile_sdk_full/dgis.dart';
import 'package:two_gis_hackaton/features/questionnary/domain/models/polygon_model.dart';
import 'package:two_gis_hackaton/features/questionnary/domain/models/ranking_model.dart';

import '../domain/models/survey_result.dart';
import '../domain/repositories/polygon_repository.dart';

/// Реализация репозитория, которая использует HTTP клиент для отправки
final class PolygonRepositoryMock implements IPolygonRepository {
  @override
  Future<RankingModel?> getPolygons(UserPreferences result, int page) async {
    await Future.delayed(const Duration(seconds: 3));
    return RankingModel(
      totalItems: 1,
      totalPages: 1,
      currentPage: 1,
      pageSize: 1,
      items: [
        PolygonModel([
          GeoPoint(
            latitude: Latitude(37.352578),
            longitude: Longitude(54.976348),
          ),
          GeoPoint(
            latitude: Latitude(37.366053),
            longitude: Longitude(54.976348),
          ),
          GeoPoint(
            latitude: Latitude(37.37279),
            longitude: Longitude(54.969651),
          ),
          GeoPoint(
            latitude: Latitude(37.370814),
            longitude: Longitude(54.967686),
          ),
          GeoPoint(
            latitude: Latitude(37.345918),
            longitude: Longitude(54.969728),
          ),
          GeoPoint(
            latitude: Latitude(37.352578),
            longitude: Longitude(54.976348),
          ),
        ], 10),
      ],
    );
  }

  @override
  Stream<RankingModel?> watchPolygons(UserPreferences result) async* {}
}
