import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../driver/controllers/driver_set_route_controller.dart';
import '../../main_nav/main_tab_nav.dart';
import '../models/ride_verification_model.dart';

class RideVerifiedController extends GetxController {
  RideVerificationModel rideData = RideVerificationModel.defaultRide;
  final RxInt selectedNavIndex = 1.obs;

  bool get isDark => rideData.isDark;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map && args['rideData'] is RideVerificationModel) {
      rideData = args['rideData'] as RideVerificationModel;
    } else {
      rideData = RideVerificationModel.defaultRide;
    }
  }

  void updateRideData(RideVerificationModel newRideData) {
    rideData = newRideData;
  }

  void seeImpact() {
    if (Get.isRegistered<DriverSetRouteController>()) {
      Get.find<DriverSetRouteController>().openRideImpact(rideData);
      return;
    }
    Get.toNamed(
      AppRoutes.rideImpact,
      arguments: {'rideData': rideData},
    );
  }

  void rateTrip() {
    if (Get.isRegistered<DriverSetRouteController>()) {
      Get.find<DriverSetRouteController>().openRateTrip(rideData);
      return;
    }
    Get.toNamed(
      AppRoutes.rateTrip,
      arguments: {'rideData': rideData},
    );
  }

  // void viewWallet() {
  //   MainTabNav.showWallet(isDark: isDark);
  // }
void viewWallet() {
  Get.toNamed(
    AppRoutes.wallet,
    arguments: {'isPushed': true},
  );
}

  void backLiveRoute() {
    if (Get.isRegistered<DriverSetRouteController>()) {
      Get.find<DriverSetRouteController>().backToLiveRide();
      return;
    }
    Get.back();
  }

  void onNavTap(int index) {
    if (index == 0) {
      MainTabNav.showHome();
      return;
    }
    if (index == 1) {
      MainTabNav.showRoute();
      return;
    }
    if (index == MainTabNav.chatIndex) {
      MainTabNav.showChat(isDark: isDark);
      return;
    }
    if (index == 3) {
      MainTabNav.showWallet(isDark: isDark);
      return;
    }
    if (index == MainTabNav.profileIndex) {
      MainTabNav.showProfile(isDark: isDark);
      return;
    }
    selectedNavIndex.value = index;
  }
}
