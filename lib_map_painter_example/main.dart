import 'package:dgis_mobile_sdk_full/dgis.dart' as sdk;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const SimpleMapApp());
}

class SimpleMapApp extends StatelessWidget {
  const SimpleMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2GIS Simple Map',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SimpleMapScreen(),
    );
  }
}

class SimpleMapScreen extends StatefulWidget {
  const SimpleMapScreen({super.key});

  @override
  State<SimpleMapScreen> createState() => _SimpleMapScreenState();
}

class _SimpleMapScreenState extends State<SimpleMapScreen> {
  final _mapController = sdk.MapWidgetController();
  final _sdkContext = AppContainer().initializeSdk();
  late final sdk.LocationService _locationService;

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
      });
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
