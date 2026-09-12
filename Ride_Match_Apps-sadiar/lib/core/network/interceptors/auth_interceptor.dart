import 'package:dio/dio.dart';

import '../../constants/api_constants.dart';
import '../../storage/secure_storage_service.dart';
import '../../utils/logger.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._secureStorage);

  final SecureStorageService _secureStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers[ApiConstants.authorizationHeader] =
          '${ApiConstants.bearerPrefix} $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      AppLogger.e('Unauthorized request', err, 'AuthInterceptor');
      // Token refresh / forced logout can be wired here later.
    }
    handler.next(err);
  }
}
