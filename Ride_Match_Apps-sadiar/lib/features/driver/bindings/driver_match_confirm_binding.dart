import 'package:get/get.dart';

import '../../chat/controllers/chat_list_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/driver_match_confirm_controller.dart';

class DriverMatchConfirmBinding extends Bindings {
  @override
  void dependencies() {
    if (Get.isRegistered<DriverMatchConfirmController>()) {
      Get.delete<DriverMatchConfirmController>(force: true);
    }
    Get.put<DriverMatchConfirmController>(DriverMatchConfirmController());
    Get.lazyPut<ProfileController>(ProfileController.new, fenix: true);
    Get.lazyPut<ChatListController>(ChatListController.new, fenix: true);
  }
}
