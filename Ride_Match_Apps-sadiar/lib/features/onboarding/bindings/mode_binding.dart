import 'package:get/get.dart';

import '../../../core/storage/secure_storage_service.dart';
import '../controllers/mode_controller.dart';
import '../services/mode_service.dart';

class ModeBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ModeService>()) {
      Get.put<ModeService>(
        ModeService(secureStorage: Get.find<SecureStorageService>()),
        permanent: true,
      );
    }

    Get.lazyPut<ModeController>(
      () => ModeController(modeService: Get.find<ModeService>()),
    );
  }
}
