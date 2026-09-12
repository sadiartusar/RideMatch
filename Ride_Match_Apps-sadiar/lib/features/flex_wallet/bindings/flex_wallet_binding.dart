import 'package:get/get.dart';
import 'package:ride_match/features/flex_wallet/controller/flex_gas_voucher_controller.dart';
import 'package:ride_match/features/flex_wallet/controller/flex_missions_controller.dart';
import 'package:ride_match/features/flex_wallet/controller/flex_wallet_controller.dart';

class FlexWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FlexWalletController>(
      () => FlexWalletController(),
      fenix: true,
    );
    Get.lazyPut<GasVoucherCheckoutController>(
      () => GasVoucherCheckoutController(),
      fenix: true,
    );
    // Get.lazyPut<FlexMissionsController>(
    //   () => FlexMissionsController(),
    //   fenix: true,
    // );
  }
}
