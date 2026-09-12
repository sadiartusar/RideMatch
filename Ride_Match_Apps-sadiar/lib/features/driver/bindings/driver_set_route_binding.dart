import 'package:get/get.dart';

import '../../chat/controllers/chat_list_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/driver_set_route_controller.dart';

class DriverSetRouteBinding extends Bindings {
  @override
  void dependencies() {
    if (Get.isRegistered<DriverSetRouteController>()) {
      Get.delete<DriverSetRouteController>(force: true);
    }
    Get.put<DriverSetRouteController>(DriverSetRouteController());
    Get.lazyPut<ProfileController>(ProfileController.new, fenix: true);
    Get.lazyPut<ChatListController>(ChatListController.new, fenix: true);
  }
}
