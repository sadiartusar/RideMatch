import 'package:get/get.dart';

import '../controllers/pre_match_chat_controller.dart';

class PreMatchChatBinding extends Bindings {
  @override
  void dependencies() {
    if (Get.isRegistered<PreMatchChatController>()) {
      Get.delete<PreMatchChatController>(force: true);
    }
    Get.put<PreMatchChatController>(PreMatchChatController());
  }
}
