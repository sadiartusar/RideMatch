import 'package:get/get.dart';

import '../../../core/network/api_client.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../../onboarding/services/mode_service.dart';
import '../controllers/auth_controller.dart';
import '../services/auth_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ModeService>()) {
      Get.put<ModeService>(
        ModeService(secureStorage: Get.find<SecureStorageService>()),
        permanent: true,
      );
    }

    // Session-scoped auth stays alive across Splash → Login → mode home.
    if (!Get.isRegistered<AuthService>()) {
      Get.put<AuthService>(
        AuthService(
          apiClient: Get.find<ApiClient>(),
          secureStorage: Get.find<SecureStorageService>(),
        ),
        permanent: true,
      );
    }

    if (!Get.isRegistered<AuthController>()) {
      Get.put<AuthController>(
        AuthController(
          authService: Get.find<AuthService>(),
          modeService: Get.find<ModeService>(),
        ),
        permanent: true,
      );
    }
  }
}
