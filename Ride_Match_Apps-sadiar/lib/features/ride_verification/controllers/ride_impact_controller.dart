import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../driver/controllers/driver_set_route_controller.dart';
import '../../main_nav/main_tab_nav.dart';
import '../models/ride_verification_model.dart';

class RideImpactController extends GetxController {
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

  void rateYourTrip() {
    if (Get.isRegistered<DriverSetRouteController>()) {
      Get.find<DriverSetRouteController>().openRateTrip(rideData);
      return;
    }
    Get.toNamed(
      AppRoutes.rateTrip,
      arguments: {'rideData': rideData},
    );
  }

  void viewWallet() {
    MainTabNav.showWallet(isDark: isDark);
  }

  void newRide() {
    if (Get.isRegistered<DriverSetRouteController>()) {
      Get.find<DriverSetRouteController>().backToSetup();
      return;
    }
    MainTabNav.showRoute();
  }

  void shareImpact(String platform) {
    Get.snackbar(
      'Share Impact',
      'Shared your 2.4 kg CO2 savings to $platform!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
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
