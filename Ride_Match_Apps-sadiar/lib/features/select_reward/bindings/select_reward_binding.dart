import 'package:get/get.dart';

import '../controllers/select_reward_controller.dart';

class SelectRewardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectRewardController>(SelectRewardController.new);
  }
}
