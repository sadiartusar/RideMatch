import 'package:get/get.dart';

import '../../../core/storage/secure_storage_service.dart';
import '../../onboarding/services/mode_service.dart';
import '../controllers/verification_controller.dart';

class VerificationBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ModeService>()) {
      Get.put<ModeService>(
        ModeService(secureStorage: Get.find<SecureStorageService>()),
        permanent: true,
      );
    }

    Get.lazyPut<VerificationController>(
      () => VerificationController(modeService: Get.find<ModeService>()),
    );
  }
}
