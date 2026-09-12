import 'package:dio/dio.dart';

import '../../utils/logger.dart';

/// Only attached to Dio when logging is enabled for the environment.
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.d('→ ${options.method} ${options.uri}', 'HTTP');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    AppLogger.d(
      '← ${response.statusCode} ${response.requestOptions.uri}',
      'HTTP',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.e(
      '${err.requestOptions.method} ${err.requestOptions.uri}',
      err.message,
      'HTTP',
    );
    handler.next(err);
  }
}
