import 'package:get/get.dart';

import '../controllers/coupon_detail_controller.dart';

class CouponDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CouponDetailController>(() => CouponDetailController());
  }
}
