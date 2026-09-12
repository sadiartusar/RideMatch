import 'package:get/get.dart';

import '../controllers/ride_verify_controller.dart';

class RideVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RideVerifyController>(() => RideVerifyController());
  }
}
