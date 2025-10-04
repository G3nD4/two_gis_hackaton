import 'package:dgis_mobile_sdk_full/dgis.dart' as sdk;
import 'package:flutter/material.dart';

class PolygonModel {
  const PolygonModel(this.points, this.score);

  final List<sdk.GeoPoint> points;
  final double score;

  Color get color {
    if (score < 0.5) return Colors.transparent;
    return Color.lerp(Colors.yellow, Colors.green, score)!.withAlpha(155);
  }

  factory PolygonModel.fromJson(Map<String, dynamic> json) {
    final String latlonString = json['wkt_latlon'] as String;
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
