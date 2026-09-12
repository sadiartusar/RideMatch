import 'package:get/get.dart';

import '../../chat/controllers/chat_list_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/driver_live_ride_controller.dart';

class DriverLiveRideBinding extends Bindings {
  @override
  void dependencies() {
    if (Get.isRegistered<DriverLiveRideController>()) {
      Get.delete<DriverLiveRideController>(force: true);
    }
    Get.put<DriverLiveRideController>(DriverLiveRideController());
    Get.lazyPut<ProfileController>(ProfileController.new, fenix: true);
    Get.lazyPut<ChatListController>(ChatListController.new, fenix: true);
  }
}
