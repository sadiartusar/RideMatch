import 'package:get/get.dart';

import '../../chat/controllers/chat_list_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../set_destination/controllers/set_destination_controller.dart';
import '../controllers/rider_home_controller.dart';

class RiderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiderHomeController>(RiderHomeController.new);
    Get.lazyPut<ProfileController>(ProfileController.new, fenix: true);
    Get.lazyPut<ChatListController>(ChatListController.new, fenix: true);
    Get.lazyPut<SetDestinationController>(
      SetDestinationController.new,
      fenix: true,
    );
  }
}
