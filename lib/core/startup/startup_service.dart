import 'dart:convert';

import 'package:two_gis_hackaton/http/app_http_client.dart';
import 'package:two_gis_hackaton/http/i_http_client.dart';

/// Сервис выполнения стартового запроса, который должен вернуть
/// необходимые данные для инициализации приложения перед показом UI.
///
/// По умолчанию делает GET запрос на `/v1/init` (пример). В реальном
/// проекте замените путь на нужный эндпоинт или внедрите через DI.
final class StartupService {
  final IHttpClient _httpClient;

  StartupService({IHttpClient? httpClient}) : _httpClient = httpClient ?? AppHttpClient();

  /// Выполняет запрос и возвращает распарсенные данные (Map) при успехе.
  /// Бросает исключение в случае любой сетевой ошибки или неверного формата.
  Future<Map<String, dynamic>> fetchInitialData({String path = '/v1/init'}) async {
    final response = await _httpClient.get(path);

    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      // Попробуем распарсить тело как JSON.
      if (response.data is String) {
        return json.decode(response.data as String) as Map<String, dynamic>;
      }

      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }

      // Если вернулся другой формат — обернём в Map
      return <String, dynamic>{'data': response.data};
    }

    throw Exception('Startup fetch failed with status: \\${response.statusCode}');
  }
}
