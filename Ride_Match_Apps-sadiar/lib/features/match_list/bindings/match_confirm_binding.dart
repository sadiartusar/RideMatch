import 'package:get/get.dart';

import '../../chat/controllers/chat_list_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/match_confirm_controller.dart';

class MatchConfirmBinding extends Bindings {
  @override
  void dependencies() {
    if (Get.isRegistered<MatchConfirmController>()) {
      Get.delete<MatchConfirmController>(force: true);
    }
    Get.put<MatchConfirmController>(MatchConfirmController());
    Get.lazyPut<ProfileController>(ProfileController.new, fenix: true);
    Get.lazyPut<ChatListController>(ChatListController.new, fenix: true);
  }
}
