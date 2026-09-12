import 'package:get/get.dart';
import '../controllers/redeem_history_controller.dart';

class RedeemHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RedeemHistoryController>(RedeemHistoryController.new);
  }
}
