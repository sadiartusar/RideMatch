/// Central API path definitions. Feature services should reference these.
class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String me = '/auth/me';

  // Placeholder endpoints for upcoming features
  static const String bookings = '/bookings';
  static const String trips = '/trips';
  static const String payments = '/payments';
  static const String profile = '/profile';
}
