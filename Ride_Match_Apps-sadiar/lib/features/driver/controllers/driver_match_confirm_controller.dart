import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../main_nav/main_tab_nav.dart';
import '../models/rider_match_model.dart';

import 'driver_set_route_controller.dart';

class DriverMatchConfirmController extends GetxController {
  RiderMatchModel match = RiderMatchModel.defaultMatches.first;
  final RxInt selectedNavIndex = 1.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map && args['match'] is RiderMatchModel) {
      match = args['match'] as RiderMatchModel;
    }
  }

  void updateMatch(RiderMatchModel newMatch) {
    match = newMatch;
  }

  void chatNow() {
    if (Get.isRegistered<DriverSetRouteController>()) {
      Get.find<DriverSetRouteController>().openChat(match);
    } else {
      Get.toNamed(
        AppRoutes.driverChat,
        arguments: {'match': match},
      );
    }
  }

  void openLiveRoute() {
    if (Get.isRegistered<DriverSetRouteController>()) {
      Get.find<DriverSetRouteController>().openLiveRide(match);
    } else {
      Get.toNamed(
        AppRoutes.driverLiveRide,
        arguments: {'match': match},
      );
    }
  }

  void viewProfile() {
    if (Get.isRegistered<DriverSetRouteController>()) {
      Get.find<DriverSetRouteController>().openProfile(match);
    } else {
      Get.toNamed(AppRoutes.profile);
    }
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
      MainTabNav.showChat(isDark: true);
      return;
    }
    if (index == 3) {
      MainTabNav.showWallet(isDark: true);
      return;
    }
    if (index == MainTabNav.profileIndex) {
      MainTabNav.showProfile(isDark: true);
      return;
    }
    selectedNavIndex.value = index;
  }
}
