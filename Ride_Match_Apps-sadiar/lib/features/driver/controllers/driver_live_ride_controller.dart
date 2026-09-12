import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../main_nav/main_tab_nav.dart';
import '../models/rider_match_model.dart';

import 'driver_set_route_controller.dart';

class DriverLiveRideController extends GetxController {
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

  void callRider() {
    Get.snackbar(
      'Calling ${match.name}',
      'Connecting secure in-app phone line...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1E2125),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void emergencySos() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xFF221111),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.warning_amber_rounded, color: Color(0xFFEF4444), size: 48),
              const SizedBox(height: 12),
              const Text(
                'Emergency SOS Active',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Instant alert with live GPS telemetry is shared with authorities & dispatch.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFFD1D5DB), fontSize: 13),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF4444),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Cancel Alert', style: TextStyle(fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void messageRider() {
    if (Get.isRegistered<DriverSetRouteController>()) {
      Get.find<DriverSetRouteController>().openChat(match);
      return;
    }
    Get.toNamed(
      AppRoutes.driverChat,
      arguments: {'match': match},
    );
  }

  void verifyCompletion() {
    if (Get.isRegistered<DriverSetRouteController>()) {
      Get.find<DriverSetRouteController>().openRideVerify(match);
      return;
    }
    Get.toNamed(
      AppRoutes.rideVerify,
      arguments: {
        'match': match,
        'isDark': true,
      },
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
