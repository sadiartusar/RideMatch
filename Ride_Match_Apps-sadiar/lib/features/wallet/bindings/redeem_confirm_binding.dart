import 'package:get/get.dart';

import '../controllers/redeem_confirm_controller.dart';

class RedeemConfirmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RedeemConfirmController>(() => RedeemConfirmController());
  }
}
