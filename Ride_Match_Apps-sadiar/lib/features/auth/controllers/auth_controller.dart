import 'package:get/get.dart';

import '../../../app/app_config.dart';
import '../../../core/errors/api_exception.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/logger.dart';
import '../../onboarding/services/mode_service.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  AuthController({
    required AuthService authService,
    required ModeService modeService,
  }) : _authService = authService,
       _modeService = modeService;

  final AuthService _authService;
  final ModeService _modeService;

  final Rxn<UserModel> currentUser = Rxn<UserModel>();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  bool get isAuthenticated => currentUser.value != null;

  Future<void> bootstrap() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      // UI-only phase: always show onboarding after splash in development.
      // Session skip returns once real auth is wired.
      if (AppConfig.isDevelopment) {
        currentUser.value = null;
        Get.offAllNamed(AppRoutes.onboarding);
        return;
      }

      final user = await _authService.restoreSession();
      currentUser.value = user;
      if (user != null) {
        final route = await _modeService.resolvePostAuthRoute();
        Get.offAllNamed(route);
      } else {
        final hasCompleted = await _modeService.hasCompletedOnboarding();
        if (!hasCompleted) {
          Get.offAllNamed(AppRoutes.onboarding);
        } else {
          Get.offAllNamed(AppRoutes.authWelcome);
        }
      }
    } catch (e) {
      AppLogger.e('Bootstrap failed', e, 'AuthController');
      Get.offAllNamed(AppRoutes.onboarding);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> continueWithEmail(String email) async {
    final trimmed = email.trim();
    if (trimmed.isEmpty) {
      errorMessage.value = 'Please enter your email address to continue.';
      Get.snackbar('Email Required', errorMessage.value);
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';
    try {
      final exists = await _authService.accountExists(trimmed);
      if (exists) {
        Get.toNamed(AppRoutes.emailLogin, arguments: trimmed);
      } else {
        Get.toNamed(AppRoutes.emailSignup, arguments: trimmed);
      }
    } catch (e) {
      errorMessage.value = 'Could not check email. Please try again.';
      AppLogger.e('Email continue failed', e, 'AuthController');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> continueWithPhone(String phone) async {
    final trimmed = phone.trim();
    if (trimmed.isEmpty) {
      errorMessage.value = 'Please enter your phone number to continue.';
      Get.snackbar('Phone Required', errorMessage.value);
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';
    try {
      final exists = await _authService.phoneAccountExists(trimmed);
      if (exists) {
        Get.toNamed(AppRoutes.phoneLogin, arguments: trimmed);
      } else {
        Get.toNamed(AppRoutes.phoneSignup, arguments: trimmed);
      }
    } catch (e) {
      errorMessage.value = 'Could not check phone. Please try again.';
      AppLogger.e('Phone continue failed', e, 'AuthController');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> completeSocialSignIn(String email) async {
    final trimmed = email.trim();
    if (trimmed.isEmpty) {
      Get.snackbar('Account Required', 'Please select an account to continue.');
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';
    try {
      final exists = await _authService.accountExists(trimmed);
      if (exists) {
        final user = await _authService.login(
          email: trimmed,
          password: 'social',
        );
        currentUser.value = user;
        final route = await _modeService.resolvePostAuthRoute();
        Get.offAllNamed(route);
      } else {
        Get.offAllNamed(AppRoutes.verificationHub);
      }
    } on ApiException catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = 'Social sign-in failed. Please try again.';
      AppLogger.e('Social sign-in failed', e, 'AuthController');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login({required String email, required String password}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final user = await _authService.login(email: email, password: password);
      currentUser.value = user;
      final route = await _modeService.resolvePostAuthRoute();
      Get.offAllNamed(route);
    } on ApiException catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = e.toString();
      AppLogger.e('Login failed', e, 'AuthController');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      await _authService.logout();
      currentUser.value = null;
      Get.offAllNamed(AppRoutes.authWelcome);
    } catch (e) {
      errorMessage.value = 'Logout failed. Please try again.';
      AppLogger.e('Logout failed', e, 'AuthController');
    } finally {
      isLoading.value = false;
    }
  }
}
