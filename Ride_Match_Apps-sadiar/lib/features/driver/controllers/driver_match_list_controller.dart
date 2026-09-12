import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../auth/models/user_model.dart';
import '../../main_nav/main_tab_nav.dart';
import '../models/rider_match_model.dart';
import '../widgets/driver_match_filter_sheet.dart';
import 'driver_set_route_controller.dart';

class DriverMatchListController extends GetxController {
  final RxList<RiderMatchModel> matches =
      RxList<RiderMatchModel>(RiderMatchModel.defaultMatches);

  final RxInt selectedNavIndex = 1.obs;
  final RxInt totalInitialCount = 3.obs;

  bool get isEmpty => matches.isEmpty;
  int get remainingCount => matches.length;

  int get displayCurrentNumber {
    if (matches.isEmpty) return 0;
    // When 3 total: 1st card = 2/3 or 1/3, matching design showing '2/3'
    final processed = totalInitialCount.value - matches.length + 1;
    return processed.clamp(1, totalInitialCount.value);
  }

  UserModel? get user {
    if (Get.isRegistered<AuthController>()) {
      return Get.find<AuthController>().currentUser.value;
    }
    return null;
  }

  void swipeLeft() {
    if (matches.isNotEmpty) {
      final dismissed = matches.removeAt(0);
      Get.snackbar(
        'Passed ${dismissed.name}',
        'Rider card dismissed.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF1E2125),
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }

  void swipeRight() {
    if (matches.isNotEmpty) {
      final rider = matches.first;
      offerRide(rider);
    }
  }

  void passCurrent() => swipeLeft();

  void offerRide(RiderMatchModel match) {
    if (Get.isRegistered<DriverSetRouteController>()) {
      Get.find<DriverSetRouteController>().openMatchConfirm(match);
    } else {
      Get.toNamed(
        AppRoutes.driverMatchConfirm,
        arguments: {'match': match},
      );
    }
  }

  void viewProfile(RiderMatchModel match) {
    if (Get.isRegistered<DriverSetRouteController>()) {
      Get.find<DriverSetRouteController>().openProfile(match);
    } else {
      Get.toNamed(AppRoutes.profile);
    }
  }

  void replyPreMatch(RiderMatchModel match) {
    if (Get.isRegistered<DriverSetRouteController>()) {
      Get.find<DriverSetRouteController>().openPreMatchChat(match);
    } else {
      Get.toNamed(
        AppRoutes.driverPreMatchChat,
        arguments: {'match': match},
      );
    }
  }

  void openFilter() {
    Get.bottomSheet(
      DriverMatchFilterSheet(
        onApply: (filter) {
          Get.snackbar(
            'Filters Applied',
            'Searching matches within ${filter.distanceRadiusKm.round()} km radius.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF1E2125),
            colorText: const Color(0xFF32E116),
            margin: const EdgeInsets.all(16),
            borderRadius: 12,
          );
        },
      ),
      isScrollControlled: true,
    );
  }

  void resetMatches() {
    matches.assignAll(RiderMatchModel.defaultMatches);
    totalInitialCount.value = matches.length;
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
