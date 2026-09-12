import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../constants/app_constants.dart';
import '../errors/api_exception.dart';
import '../storage/secure_storage_service.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

/// Single shared Dio client for the whole app.
/// Feature services must call this — never create their own Dio instance.
///
/// [baseUrl] and [enableLogging] are injected by `app/app_bindings.dart` so
/// that `core/` never depends on application-level configuration.
class ApiClient {
  ApiClient({
    required SecureStorageService secureStorage,
    required String baseUrl,
    bool enableLogging = false,
    Dio? dio,
  }) : _dio = dio ?? Dio() {
    _dio
      ..options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(
          seconds: AppConstants.connectTimeoutSeconds,
        ),
        receiveTimeout: const Duration(
          seconds: AppConstants.receiveTimeoutSeconds,
        ),
        headers: {
          Headers.contentTypeHeader: ApiConstants.contentType,
          Headers.acceptHeader: ApiConstants.accept,
        },
      )
      ..interceptors.addAll([
        AuthInterceptor(secureStorage),
        if (enableLogging) LoggingInterceptor(),
      ]);
  }

  final Dio _dio;

  Dio get dio => _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _request(
      () =>
          _dio.get<T>(path, queryParameters: queryParameters, options: options),
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _request(
      () => _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _request(
      () => _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _request(
      () => _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _request(
      () => _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  Future<Response<T>> _request<T>(Future<Response<T>> Function() call) async {
    try {
      return await call();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ApiException.unknown(e.toString());
    }
  }

  ApiException _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return ApiException.timeout();
      case DioExceptionType.connectionError:
        return ApiException.noInternet();
      case DioExceptionType.badResponse:
        return _mapStatusCode(e.response?.statusCode, e.response?.data);
      case DioExceptionType.cancel:
        return ApiException.unknown('Request was cancelled.');
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return ApiException.unknown(e.message);
    }
  }

  ApiException _mapStatusCode(int? statusCode, dynamic data) {
    final message = _extractMessage(data);

    switch (statusCode) {
      case 401:
        return ApiException.unauthorized(message);
      case 403:
        return ApiException.forbidden(message);
      case 404:
        return ApiException.notFound(message);
      case 422:
        return ApiException.validation(message);
      case 500:
      case 502:
      case 503:
        return ApiException.server(message);
      default:
        return ApiException(
          message: message ?? 'Request failed.',
          statusCode: statusCode,
        );
    }
  }

  String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      final message = data['message'] ?? data['error'];
      if (message is String) return message;
    }
    if (data is String && data.isNotEmpty) return data;
    return null;
  }
}
