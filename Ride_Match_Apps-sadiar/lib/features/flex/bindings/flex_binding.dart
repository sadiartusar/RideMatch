import 'package:get/get.dart';
import 'package:ride_match/features/flex_wallet/controller/flex_gas_voucher_controller.dart';
import 'package:ride_match/features/flex_wallet/controller/flex_missions_controller.dart';
import 'package:ride_match/features/flex_wallet/controller/flex_wallet_controller.dart';

import '../../chat/controllers/chat_list_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../set_destination/controllers/set_destination_controller.dart';
import '../controllers/flex_home_controller.dart';

class FlexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FlexHomeController>(FlexHomeController.new);
    Get.lazyPut<ProfileController>(ProfileController.new, fenix: true);
    Get.lazyPut<ChatListController>(ChatListController.new, fenix: true);
    Get.lazyPut<SetDestinationController>(
      SetDestinationController.new,
      fenix: true,
    );
     Get.lazyPut<FlexWalletController>(
      () => FlexWalletController(),fenix: true
    );
    Get.lazyPut<FlexMissionsController>(
      () => FlexMissionsController(),
      fenix: true,
    );
    // Get.lazyPut<GasVoucherCheckoutController>(
    //   () => GasVoucherCheckoutController(),fenix: true
    // );
  }
}
