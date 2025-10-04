// NOTE: This file uses `get_it`. Add `get_it: ^7.3.0` to your `pubspec.yaml`
// dependencies and run `flutter pub get`.
import 'package:get_it/get_it.dart';
import 'package:two_gis_hackaton/core/i_startup_service.dart';
import 'package:two_gis_hackaton/core/startup/mock_startup_service.dart';
import 'package:two_gis_hackaton/core/startup/startup_service.dart';
import 'package:two_gis_hackaton/core/launch_mode.dart';

import 'package:two_gis_hackaton/features/questionnary/data/polygon_repository_mock.dart';
import 'package:two_gis_hackaton/features/questionnary/data/polygon_repository_impl.dart';
import 'package:two_gis_hackaton/features/questionnary/data/prefs_repository_impl.dart';
import 'package:two_gis_hackaton/features/questionnary/domain/repositories/i_prefs_repository.dart';
import 'package:two_gis_hackaton/features/questionnary/domain/repositories/polygon_repository.dart';

final GetIt sl = GetIt.instance;

/// Register app-wide singletons/factories here. Use [mode] to select mock
/// implementations (dev) or real implementations (release).
Future<void> setupServiceLocator({LaunchMode mode = LaunchMode.dev}) async {
  // Clear any existing registrations when re-setting up
  if (sl.isRegistered<IStartupService>()) {
    sl.reset();
  }

  if (mode == LaunchMode.dev) {
    // Dev: use mock implementations
    sl.registerLazySingleton<IStartupService>(() => MockStartupService());
    sl.registerLazySingleton<IPolygonRepository>(() => PolygonRepositoryMock());
    sl.registerLazySingleton<IPrefsRepository>(() => PrefsRepositoryImpl());
  } else {
    // Release: use real implementations
    sl.registerLazySingleton<IStartupService>(() => StartupService());
    sl.registerLazySingleton<IPolygonRepository>(() => PolygonRepositoryImpl());
    sl.registerLazySingleton<IPrefsRepository>(() => PrefsRepositoryImpl());
  }
}
