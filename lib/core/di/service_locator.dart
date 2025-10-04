// NOTE: This file uses `get_it`. Add `get_it: ^7.3.0` to your `pubspec.yaml`
// dependencies and run `flutter pub get`.
import 'package:get_it/get_it.dart';
import 'package:two_gis_hackaton/core/i_startup_service.dart';
import 'package:two_gis_hackaton/core/startup/mock_startup_service.dart';
import 'package:two_gis_hackaton/features/questionnary/data/questionnary_repository_mock.dart';
import 'package:two_gis_hackaton/features/questionnary/domain/usecases/send_survey_usecase.dart';

final GetIt sl = GetIt.instance;

/// Register app-wide singletons/factories here.
Future<void> setupServiceLocator() async {
  // Startup service
  sl.registerLazySingleton<IStartupService>(() => MockStartupService());

  // Questionnary dependencies
  sl.registerLazySingleton(() => QuestionnaryRepositoryMock());
  sl.registerLazySingleton(() => SendSurveyUseCase(sl()));
}
