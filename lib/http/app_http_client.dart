import 'package:dio/dio.dart';
import 'package:two_gis_hackaton/http/i_http_client.dart';

const String _baseUrl = 'https://renewable-rotary-clinton-rush.trycloudflare.com';

final class AppHttpClient implements IHttpClient {
  /// Создает HTTP клиент
  ///
  /// Принимает:
  /// - [debugService] - сервис для логирования запросов
  /// - [appConfig] - конфигурация приложения
  AppHttpClient() {
    _httpClient = Dio();

    _httpClient.options
      ..baseUrl = _baseUrl
      ..connectTimeout = const Duration(seconds: 30)
      ..sendTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30)
      ..headers = {'Content-Type': 'application/json'};
  }

  /// Конфигурация приложения

  /// Экземпляр HTTP клиента
  late final Dio _httpClient;

  @override
  Future<Response> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    _httpClient.options.baseUrl = _baseUrl;

    return _httpClient.get(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  @override
  Future<Response> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    _httpClient.options.baseUrl = _baseUrl;

    return _httpClient.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  @override
  Future<Response> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    _httpClient.options.baseUrl = _baseUrl;

    return _httpClient.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  @override
  Future<Response> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    _httpClient.options.baseUrl = _baseUrl;

    return _httpClient.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  @override
  Future<Response> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    _httpClient.options.baseUrl = _baseUrl;

    return _httpClient.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  @override
  Future<Response> head(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    _httpClient.options.baseUrl = _baseUrl;

    return _httpClient.head(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
