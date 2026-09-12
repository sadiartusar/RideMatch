import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    if (Get.isRegistered<ProfileController>()) return;
    Get.lazyPut<ProfileController>(ProfileController.new);
  }
}
