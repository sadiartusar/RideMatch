import 'package:get/get.dart';

import '../core/network/api_client.dart';
import '../core/storage/secure_storage_service.dart';
import '../features/onboarding/services/mode_service.dart';
import 'app_config.dart';

/// Registers app-wide infrastructure once at startup.
/// Feature dependencies belong in their own feature binding.
class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<SecureStorageService>(SecureStorageService(), permanent: true);

    Get.put<ApiClient>(
      ApiClient(
        secureStorage: Get.find<SecureStorageService>(),
        baseUrl: AppConfig.baseUrl,
        enableLogging: AppConfig.enableLogging,
      ),
      permanent: true,
    );

    Get.put<ModeService>(
      ModeService(secureStorage: Get.find<SecureStorageService>()),
      permanent: true,
    );
  }
}
