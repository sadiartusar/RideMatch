import '../../../core/errors/api_exception.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../../../core/storage/storage_keys.dart';
import '../../../core/utils/logger.dart';
import '../models/user_model.dart';

/// Auth data operations. Controllers call this — never Dio directly.
class AuthService {
  AuthService({required this._apiClient, required this._secureStorage});

  // Wired for real API calls; mock path is used until backend is ready.
  // ignore: unused_field
  final ApiClient _apiClient;
  final SecureStorageService _secureStorage;

  /// Mock login for architecture demo. Replace with real API call later.
  ///
  /// Real flow:
  /// ```dart
  /// final response = await _apiClient.post(
  ///   ApiEndpoints.login,
  ///   data: {'email': email, 'password': password},
  /// );
  /// ```
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    AppLogger.d('Login attempt for $email', 'AuthService');
    await Future<void>.delayed(const Duration(milliseconds: 800));

    if (email.trim().isEmpty || password.isEmpty) {
      throw const ApiException(
        message: 'Email and password are required',
        type: ApiErrorType.validation,
        statusCode: 422,
      );
    }

    await _secureStorage.saveTokens(
      accessToken: 'mock_access_token',
      refreshToken: 'mock_refresh_token',
    );

    final user = UserModel(
      id: 'user_001',
      name: 'Demo Rider',
      email: email.trim(),
      phone: '+10000000000',
    );

    await _secureStorage.write(StorageKeys.userId, user.id);
    return user;
  }

  Future<void> logout() async {
    // Real flow: await _apiClient.post(ApiEndpoints.logout);
    await _secureStorage.clearTokens();
    await _secureStorage.delete(StorageKeys.userId);
    AppLogger.d('User logged out', 'AuthService');
  }

  /// UI mock: known demo emails are treated as existing accounts.
  /// Any other email is treated as a new user.
  Future<bool> accountExists(String email) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    const existing = {
      'carlton.johnson@email.com',
      'demo@ridematch.com',
      'carlton.johnson@gmail.com',
      'carlton.j@icloud.com',
    };
    return existing.contains(email.trim().toLowerCase());
  }

  /// UI mock: known demo phones are treated as existing accounts.
  Future<bool> phoneAccountExists(String phone) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final normalized = normalizePhone(phone);
    const existing = {
      '+15871XXXXXXXXX',
      '+10000000000',
      '15871XXXXXXXXX',
    };
    return existing.contains(normalized);
  }

  static String normalizePhone(String phone) {
    return phone.replaceAll(RegExp(r'[\s\-]'), '');
  }

  Future<bool> hasValidSession() => _secureStorage.hasAccessToken();

  Future<UserModel?> restoreSession() async {
    final hasToken = await hasValidSession();
    if (!hasToken) return null;

    // Real flow: GET ApiEndpoints.me via _apiClient.
    return const UserModel(
      id: 'user_001',
      name: 'Demo Rider',
      email: 'demo@ridematch.com',
      phone: '+10000000000',
    );
  }

  /// Endpoint reference kept for upcoming real auth integration.
  static String get loginEndpoint => ApiEndpoints.login;
}
