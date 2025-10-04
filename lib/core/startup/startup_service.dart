import 'dart:convert';

import 'package:two_gis_hackaton/http/app_http_client.dart';
import 'package:two_gis_hackaton/http/i_http_client.dart';
import 'package:two_gis_hackaton/core/i_startup_service.dart';

/// Сервис выполнения стартового запроса, который должен вернуть
/// необходимые данные для инициализации приложения перед показом UI.
///
/// По умолчанию делает GET запрос на `/v1/init` (пример). В реальном
/// проекте замените путь на нужный эндпоинт или внедрите через DI.
final class StartupService implements IStartupService {
  final IHttpClient _httpClient;

  StartupService({IHttpClient? httpClient}) : _httpClient = httpClient ?? AppHttpClient();

  /// Implements IStartupService - attempts to fetch a list of survey
  /// interests/strings from the startup endpoint. This is a convenience
  /// adapter that maps the JSON result to List<String> when possible.
  @override
  Future<List<String>> fetchSurveyData() async {
    final response = await _httpClient.get('/categories');

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch survey data: ${response.statusCode}');
    }

    if (response.data is List) {
      return (response.data as List).map((e) => e.toString()).toList();
    }

    // Fallback: empty list
    return <String>[];
  }
}
