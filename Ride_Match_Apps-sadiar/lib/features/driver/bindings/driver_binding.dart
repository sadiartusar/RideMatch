import 'package:get/get.dart';

import '../../chat/controllers/chat_list_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../wallet/controllers/wallet_controller.dart';
import '../controllers/driver_home_controller.dart';
import '../controllers/driver_set_route_controller.dart';

class DriverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverHomeController>(DriverHomeController.new);
    Get.lazyPut<ProfileController>(ProfileController.new, fenix: true);
    Get.lazyPut<ChatListController>(ChatListController.new, fenix: true);
    Get.lazyPut<DriverSetRouteController>(DriverSetRouteController.new, fenix: true);
    Get.lazyPut<WalletController>(WalletController.new, fenix: true);
  }
}
