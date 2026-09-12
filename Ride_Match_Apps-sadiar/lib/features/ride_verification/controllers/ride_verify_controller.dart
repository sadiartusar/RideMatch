import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../driver/controllers/driver_set_route_controller.dart';
import '../../driver/models/rider_match_model.dart';
import '../../main_nav/main_tab_nav.dart';
import '../models/ride_verification_model.dart';

class RideVerifyController extends GetxController {
  RideVerificationModel rideData = RideVerificationModel.defaultRide;
  late final TextEditingController pinController;

  final RxInt selectedTabIndex = 0.obs; // 0 = PIN, 1 = QR
  final RxBool isVerifying = false.obs;
  final RxInt selectedNavIndex = 1.obs;

  bool get isDark => rideData.isDark;

  @override
  void onInit() {
    super.onInit();
    pinController = TextEditingController();

    final args = Get.arguments;
    if (args is Map) {
      final match = args['match'];
      final bool isDarkMode = args['isDark'] ?? true;
      if (match is RiderMatchModel) {
        rideData = RideVerificationModel(
          riderName: match.name,
          riderAvatar: match.avatarAsset,
          pinCode: '4821',
          qrPayload: 'RIDEMATCH_VERIFY_${match.id}',
          sharedKm: match.sharedKm > 0 ? match.sharedKm : 4.8,
          couponsTransferred: 1,
          gasVoucherAmount: match.netEarnings > 0 ? match.netEarnings : 9.60,
          co2SavedKg: 2.4,
          fuelSavedPercent: 17,
          rewardPoints: 125,
          isDark: isDarkMode,
        );
      } else if (args['rideData'] is RideVerificationModel) {
        rideData = args['rideData'] as RideVerificationModel;
      } else {
        rideData = RideVerificationModel.defaultRide;
      }
    } else {
      rideData = RideVerificationModel.defaultRide;
    }
  }

  void updateRideData(RideVerificationModel newRideData) {
    rideData = newRideData;
  }

  void switchTab(int index) {
    selectedTabIndex.value = index;
  }

  void onMicTap() {
    Get.snackbar(
      'Voice PIN',
      'Speak your 4-digit verification code.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void scanQrCode() {
    Get.snackbar(
      'QR Scanner',
      'Opening camera scanner...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void confirmCompletion() {
    isVerifying.value = true;
    Future.delayed(const Duration(milliseconds: 350), () {
      isVerifying.value = false;
      if (Get.isRegistered<DriverSetRouteController>()) {
        Get.find<DriverSetRouteController>().openRideVerified(rideData);
        return;
      }
      Get.toNamed(
        AppRoutes.rideVerified,
        arguments: {'rideData': rideData},
      );
    });
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

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }
}
