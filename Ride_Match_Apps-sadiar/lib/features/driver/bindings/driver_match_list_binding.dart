import 'package:get/get.dart';

import '../../chat/controllers/chat_list_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/driver_match_list_controller.dart';

class DriverMatchListBinding extends Bindings {
  @override
  void dependencies() {
    if (Get.isRegistered<DriverMatchListController>()) {
      Get.delete<DriverMatchListController>(force: true);
    }
    Get.put<DriverMatchListController>(DriverMatchListController());
    Get.lazyPut<ProfileController>(ProfileController.new, fenix: true);
    Get.lazyPut<ChatListController>(ChatListController.new, fenix: true);
  }
}
