import 'package:get/get.dart';

import '../../chat/controllers/chat_list_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/match_list_controller.dart';

class MatchListBinding extends Bindings {
  @override
  void dependencies() {
    if (Get.isRegistered<MatchListController>()) {
      Get.delete<MatchListController>(force: true);
    }
    Get.put<MatchListController>(MatchListController());
    Get.lazyPut<ProfileController>(ProfileController.new, fenix: true);
    Get.lazyPut<ChatListController>(ChatListController.new, fenix: true);
  }
}
