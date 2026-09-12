import 'package:get/get.dart';

import '../controllers/user_profile_controller.dart';

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    if (Get.isRegistered<UserProfileController>()) {
      Get.delete<UserProfileController>(force: true);
    }
    Get.put<UserProfileController>(UserProfileController());
  }
}
