import 'package:get/get.dart';

import '../controllers/ride_impact_controller.dart';

class RideImpactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RideImpactController>(() => RideImpactController());
  }
}
