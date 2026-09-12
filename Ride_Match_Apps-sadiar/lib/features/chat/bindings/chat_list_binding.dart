import 'package:get/get.dart';

import '../controllers/chat_list_controller.dart';

class ChatListBinding extends Bindings {
  @override
  void dependencies() {
    if (Get.isRegistered<ChatListController>()) return;
    Get.lazyPut<ChatListController>(ChatListController.new);
  }
}
