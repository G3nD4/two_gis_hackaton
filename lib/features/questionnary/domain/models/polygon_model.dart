import 'package:dgis_mobile_sdk_full/dgis.dart' as sdk;
import 'package:flutter/material.dart';

class PolygonModel {
  const PolygonModel(this.points, this.score);

  final List<sdk.GeoPoint> points;
  final double score;

  Color get color {
    if (score < 0.65) return Colors.transparent;
    if (score < 0.75) return Color(0xFFF0FFCC).withAlpha(155);
    if (score < 0.85) return Color(0xFFCCFF66).withAlpha(155);
    if (score < 0.9) return Color(0xFF78DD67).withAlpha(155);
    if (score < 0.98) return Color(0xFF109944).withAlpha(155);
    return Color(0xFF004422).withAlpha(155);
  }

  factory PolygonModel.fromJson(Map<String, dynamic> json) {
    final String latlonString = json['wkt'] as String;
    // lon lat format
    if (latlonString.length < 11) {
      throw ArgumentError(
        'Polygon data string length cannot be less that 11 symbols.',
      );
    }

    final List<String> pointsList = latlonString
        .substring(10, latlonString.length - 2)
        .split(', ');

    return PolygonModel(
      pointsList.map((elem) => _parseGeopoint(elem)).toList(),
      json['score'] as double,
    );
  }

  static sdk.GeoPoint _parseGeopoint(String string) {
    final List<String> pair = string.split(' ');
    if (pair.length != 2) {
      throw ArgumentError(
        'String must be of "*lon_double* *lat_double*" format.',
      );
    }

    final double? lon = double.tryParse(pair[0]);
    final double? lat = double.tryParse(pair[1]);

    if (lon == null || lat == null) {
      throw ArgumentError(
        'String must be of "*lon_double* *lat_double*" format.',
      );
    }

    return sdk.GeoPoint(
      latitude: sdk.Latitude(lat),
      longitude: sdk.Longitude(lon),
    );
  }
}
