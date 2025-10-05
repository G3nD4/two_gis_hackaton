import 'package:dgis_mobile_sdk_full/dgis.dart' as sdk;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:two_gis_hackaton/core/di/service_locator.dart';
import 'package:two_gis_hackaton/features/questionnary/domain/models/ranking_model.dart';
import 'package:two_gis_hackaton/features/questionnary/domain/repositories/i_prefs_repository.dart';
import 'package:two_gis_hackaton/features/questionnary/domain/repositories/polygon_repository.dart';
import 'package:two_gis_hackaton/utils/figures_painter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _mapController = sdk.MapWidgetController();
  final _sdkContext = AppContainer().initializeSdk();
  late final sdk.LocationService _locationService;
  sdk.MapObjectManager? _mapObjectManager;

  @override
  void initState() {
    super.initState();
    _locationService = sdk.LocationService(_sdkContext);
    _checkLocationPermissions(_locationService).then((_) {
      _mapController.getMapAsync((map) {
        final locationSource = sdk.MyLocationMapObjectSource(_sdkContext);
        map.addSource(locationSource);
        map.camera.position = const sdk.CameraPosition(
          point: sdk.GeoPoint(
            latitude: sdk.Latitude(55.35),
            longitude: sdk.Longitude(37.42),
          ),
          zoom: sdk.Zoom(10),
        );
        _mapObjectManager = sdk.MapObjectManager(map);

        // Get polygons to display on the map
        _getPolygons();
      });
    });
  }

  Future<void> _getPolygons() async {
    sl.get<IPrefsRepository>().getUserPreferences().then((prefs) {
      if (prefs != null) {
        sl.get<IPolygonRepository>().watchPolygons(prefs).listen((
          RankingModel? rank,
        ) {
          if (rank != null &&
              rank.items.isNotEmpty &&
              _mapObjectManager != null) {
            _mapController.getMapAsync((map) {
              rank.items.forEach(MapPainter(_mapObjectManager!).addPolygon);
            });
          }
        });
      }
    });
  }

  Future<void> _checkLocationPermissions(
    sdk.LocationService locationService,
  ) async {
    final permission = await Permission.location.request();
    if (permission.isGranted) {
      locationService.onPermissionGranted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: sdk.MapWidget(
        sdkContext: _sdkContext,
        mapOptions: sdk.MapOptions(),
        controller: _mapController,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: sdk.TrafficWidget(),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        sdk.ZoomWidget(),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: sdk.CompassWidget(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: sdk.MyLocationWidget(),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Align(alignment: Alignment.centerLeft, child: sdk.IndoorWidget()),
            ],
          ),
        ),
      ),
    );
  }
}

class AppContainer {
  static sdk.Context? _sdkContext;

  sdk.Context initializeSdk() {
    _sdkContext ??= sdk.DGis.initialize(
      logOptions: const sdk.LogOptions(
        systemLevel: sdk.LogLevel.verbose,
        customLevel: sdk.LogLevel.verbose,
      ),
    );
    return _sdkContext!;
  }
}
