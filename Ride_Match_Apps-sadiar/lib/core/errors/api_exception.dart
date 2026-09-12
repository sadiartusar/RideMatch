/// Domain-level API error. UI and controllers should use this, not raw Dio errors.
class ApiException implements Exception {
  const ApiException({
    required this.message,
    this.statusCode,
    this.type = ApiErrorType.unknown,
  });

  final String message;
  final int? statusCode;
  final ApiErrorType type;

  factory ApiException.noInternet() {
    return const ApiException(
      message: 'No internet connection. Please check your network.',
      type: ApiErrorType.noInternet,
    );
  }

  factory ApiException.timeout() {
    return const ApiException(
      message: 'Request timed out. Please try again.',
      type: ApiErrorType.timeout,
    );
  }

  factory ApiException.unauthorized([String? message]) {
    return ApiException(
      message: message ?? 'Session expired. Please log in again.',
      statusCode: 401,
      type: ApiErrorType.unauthorized,
    );
  }

  factory ApiException.forbidden([String? message]) {
    return ApiException(
      message: message ?? 'You do not have permission to perform this action.',
      statusCode: 403,
      type: ApiErrorType.forbidden,
    );
  }

  factory ApiException.notFound([String? message]) {
    return ApiException(
      message: message ?? 'The requested resource was not found.',
      statusCode: 404,
      type: ApiErrorType.notFound,
    );
  }

  factory ApiException.validation([String? message]) {
    return ApiException(
      message: message ?? 'Validation failed. Please check your input.',
      statusCode: 422,
      type: ApiErrorType.validation,
    );
  }

  factory ApiException.server([String? message]) {
    return ApiException(
      message: message ?? 'Something went wrong on our side. Please try again.',
      statusCode: 500,
      type: ApiErrorType.server,
    );
  }

  factory ApiException.unknown([String? message]) {
    return ApiException(
      message: message ?? 'An unexpected error occurred.',
      type: ApiErrorType.unknown,
    );
  }

  @override
  String toString() => 'ApiException($type, $statusCode): $message';
}

enum ApiErrorType {
  noInternet,
  timeout,
  unauthorized,
  forbidden,
  notFound,
  validation,
  server,
  unknown,
}
