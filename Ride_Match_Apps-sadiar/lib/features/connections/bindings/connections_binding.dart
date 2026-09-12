import 'package:get/get.dart';

import '../controllers/connections_controller.dart';

class ConnectionsBinding extends Bindings {
  @override
  void dependencies() {
    if (Get.isRegistered<ConnectionsController>()) {
      Get.delete<ConnectionsController>(force: true);
    }
    Get.put<ConnectionsController>(ConnectionsController());
  }
}
