import 'package:dgis_mobile_sdk_full/dgis.dart' as sdk;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'utils/figures_painter.dart';

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
  sdk.MapObjectManager? _mapObjectManager;

  @override
  void initState() {
    super.initState();
    _locationService = sdk.LocationService(_sdkContext);
    _mapController.getMapAsync((map) {
      _mapObjectManager = sdk.MapObjectManager(map);
      // Add a hexagon around current camera center when map is ready
      final center = map.camera.position.point;
      if (_mapObjectManager != null) {
        MapPainter(
          _mapObjectManager!,
        ).addHexagon(center, 200); // 200 meters radius
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

  Future<void> _onGetLocationPressed() async {
    await _checkLocationPermissions(_locationService);

    final last = _locationService.lastLocation().value;
    if (last == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location not available yet')),
      );
      return;
    }

    final coords = last.coordinates.value;
    final lat = coords.latitude.value.toStringAsFixed(6);
    final lon = coords.longitude.value.toStringAsFixed(6);
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Current location'),
        content: Text('Latitude: $lat\nLongitude: $lon'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _onGetLocationPressed,
            tooltip: 'Get current location',
          ),
        ],
      ),
      body: sdk.MapWidget(
        sdkContext: _sdkContext,
        mapOptions: sdk.MapOptions(),
        controller: _mapController,
      ),
    );
  }
}

// Minimal copy of AppContainer from example to initialize SDK.
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
