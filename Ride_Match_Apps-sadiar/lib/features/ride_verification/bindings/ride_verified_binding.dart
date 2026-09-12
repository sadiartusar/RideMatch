import 'package:get/get.dart';

import '../controllers/ride_verified_controller.dart';

class RideVerifiedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RideVerifiedController>(() => RideVerifiedController());
  }
}
