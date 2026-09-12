import 'package:get/get.dart';

import '../controllers/community_details_controller.dart';

class CommunityDetailsBinding extends Bindings {
  @override
  void dependencies() {
    if (Get.isRegistered<CommunityDetailsController>()) {
      Get.delete<CommunityDetailsController>(force: true);
    }
    Get.put<CommunityDetailsController>(CommunityDetailsController());
  }
}
