import 'dart:math' as math;

import 'package:dgis_mobile_sdk_full/dgis.dart' as sdk;

final class MapPainter {
  const MapPainter(this._manager);

  final sdk.MapObjectManager _manager;

  void addHexagon(
    sdk.GeoPoint center,
    double radiusMeters,
  ) {
    const int sides = 6;
    const double R = 6371000.0; // Earth's radius in meters
    final lat1 = center.latitude.value * math.pi / 180.0;
    final lon1 = center.longitude.value * math.pi / 180.0;
    final d = radiusMeters / R;

    final points = <sdk.GeoPoint>[];
    for (var i = 0; i < sides; i++) {
      final bearing = (i * 360.0 / sides) * math.pi / 180.0;
      final lat2 = math.asin(
        math.sin(lat1) * math.cos(d) +
            math.cos(lat1) * math.sin(d) * math.cos(bearing),
      );
      final lon2 =
          lon1 +
          math.atan2(
            math.sin(bearing) * math.sin(d) * math.cos(lat1),
            math.cos(d) - math.sin(lat1) * math.sin(lat2),
          );
      final lat2deg = lat2 * 180.0 / math.pi;
      final lon2deg = lon2 * 180.0 / math.pi;

      points.add(
        sdk.GeoPoint(
          latitude: sdk.Latitude(lat2deg),
          longitude: sdk.Longitude(lon2deg),
        ),
      );
    }

    final polygon = sdk.Polygon(
      sdk.PolygonOptions(
        contours: [points],
        strokeWidth: sdk.LogicalPixel(2),
        userData: 'hexagon',
        color: sdk.Color(0x55FF0000), // semi-transparent red
        strokeColor: sdk.Color(0xFF000000),
      ),
    );

    final centerCircle = sdk.Circle(
      sdk.CircleOptions(
        position: center,
        radius: sdk.Meter(5),
        color: sdk.Color(0xFF0000FF),
        strokeWidth: sdk.LogicalPixel(1),
        strokeColor: sdk.Color(0xFF000000),
      ),
    );

    _manager.addObject(polygon);
    _manager.addObject(centerCircle);
  }
}
