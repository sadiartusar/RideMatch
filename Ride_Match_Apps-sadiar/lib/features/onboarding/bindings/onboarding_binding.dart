import 'package:get/get.dart';

import '../../../core/storage/secure_storage_service.dart';
import '../controllers/onboarding_controller.dart';
import '../services/mode_service.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ModeService>()) {
      Get.put<ModeService>(
        ModeService(secureStorage: Get.find<SecureStorageService>()),
        permanent: true,
      );
    }

    Get.lazyPut<OnboardingController>(
      () => OnboardingController(modeService: Get.find<ModeService>()),
    );
  }
}
