import 'package:get/get.dart';

import '../controllers/connection_requests_controller.dart';

class ConnectionRequestsBinding extends Bindings {
  @override
  void dependencies() {
    if (Get.isRegistered<ConnectionRequestsController>()) {
      Get.delete<ConnectionRequestsController>(force: true);
    }
    Get.put<ConnectionRequestsController>(ConnectionRequestsController());
  }
}
