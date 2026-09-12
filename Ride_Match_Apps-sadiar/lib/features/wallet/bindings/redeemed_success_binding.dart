import 'package:get/get.dart';
import '../controllers/redeemed_success_controller.dart';

class RedeemedSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RedeemedSuccessController>(RedeemedSuccessController.new);
  }
}
