import 'package:get/get.dart';

import '../../chat/controllers/chat_list_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/driver_pre_match_chat_controller.dart';

class DriverPreMatchChatBinding extends Bindings {
  @override
  void dependencies() {
    if (Get.isRegistered<DriverPreMatchChatController>()) {
      Get.delete<DriverPreMatchChatController>(force: true);
    }
    Get.put<DriverPreMatchChatController>(DriverPreMatchChatController());
    Get.lazyPut<ProfileController>(ProfileController.new, fenix: true);
    Get.lazyPut<ChatListController>(ChatListController.new, fenix: true);
  }
}
