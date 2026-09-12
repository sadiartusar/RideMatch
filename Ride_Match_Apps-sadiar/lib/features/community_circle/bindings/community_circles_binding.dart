import 'package:get/get.dart';

import '../controllers/community_circles_controller.dart';

class CommunityCirclesBinding extends Bindings {
  @override
  void dependencies() {
    if (Get.isRegistered<CommunityCirclesController>()) {
      Get.delete<CommunityCirclesController>(force: true);
    }
    Get.put<CommunityCirclesController>(CommunityCirclesController());
  }
}
