import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_match/features/driver/controllers/driver_set_route_controller.dart';
import 'package:ride_match/features/onboarding/models/user_mode.dart';
import 'package:ride_match/features/onboarding/services/mode_service.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../auth/models/user_model.dart';
import '../../drawer/controllers/app_drawer_controller.dart';
import '../../drawer/models/drawer_nav_item.dart';
import '../../set_destination/controllers/set_destination_controller.dart';
import '../models/commute_mode_option.dart';
import '../../main_nav/main_tab_nav.dart';

class CreateModeController extends GetxController {
  final Rx<CommuteModeType> selectedMode = CommuteModeType.rideRequest.obs;
  final RxInt selectedNavIndex = MainTabNav.findIndex.obs;

  final RxInt nearbyRiders = 3.obs;
  final RxInt routeSharePercent = 82.obs;
  final RxInt earnCoupons = 45.obs;
  final RxInt trustScore = 88.obs;
  final RxInt mutualCirclesExtra = 12.obs;

  final List<CommuteModeOption> options = CommuteModeOption.defaults;

  final List<String> mutualAvatarUrls = const [
    'https://i.pravatar.cc/100?img=12',
    'https://i.pravatar.cc/100?img=32',
    'https://i.pravatar.cc/100?img=47',
  ];

  UserModel? get user {
    if (Get.isRegistered<AuthController>()) {
      return Get.find<AuthController>().currentUser.value;
    }
    return null;
  }

  String get displayName {
    final name = user?.name.trim();
    if (name != null && name.isNotEmpty) return name;
    return 'Jeremy M. Ralston';
  }

  void selectMode(CommuteModeType mode) {
    selectedMode.value = mode;
    if (mode == CommuteModeType.rideRequest) {
      Get.toNamed(AppRoutes.selectReward);
    } else if (mode == CommuteModeType.offerSeats) {
      if (Get.isRegistered<ModeService>()) {
        Get.find<ModeService>().setMode(UserMode.driver);
      }

      if (Get.isRegistered<DriverSetRouteController>()) {
        final driverRouteCtrl = Get.find<DriverSetRouteController>();
        driverRouteCtrl.previewMatches();
      } else {
        Get.toNamed(AppRoutes.driverMatchList);
      }
    }
  }

  void goBack() {
    if (Get.isRegistered<SetDestinationController>()) {
      final setDestination = Get.find<SetDestinationController>();
      if (setDestination.step.value == SetDestinationStep.createMode) {
        setDestination.step.value = SetDestinationStep.destination;
        return;
      }
    }
    Get.back();
  }

  void offerSeatsNow() {
    selectedMode.value = CommuteModeType.offerSeats;
    Get.snackbar(
      'Offer Seats',
      'Switched to Offer Seats — ${nearbyRiders.value} nearby riders match '
          '${routeSharePercent.value}% of your route.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: AppColors.button,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void selectReward() {
    selectedMode.value = CommuteModeType.rideRequest;
    Get.toNamed(AppRoutes.selectReward);
  }

  void openNotifications() {
    Get.toNamed(AppRoutes.notifications);
  }

  void openMenu() {
    AppDrawerController.open(
      userName: displayName,
      selectedId: DrawerNavId.home,
      onOpenNotifications: openNotifications,
      onChangeMode: () => Get.toNamed(AppRoutes.chooseMode),
    );
  }

  void onNavTap(int index) {
    selectedNavIndex.value = index;
    switch (index) {
      case MainTabNav.homeIndex:
        MainTabNav.showHome();
        break;
      case MainTabNav.findIndex:
        // Stay on Choose Mode (Find flow).
        break;
      case MainTabNav.chatIndex:
        MainTabNav.showChat();
        break;
      case 3:
        MainTabNav.showWallet();
        break;
      case MainTabNav.profileIndex:
        MainTabNav.showProfile();
        break;
    }
  }

  static void ensureController() {
    if (!Get.isRegistered<CreateModeController>()) {
      Get.put(CreateModeController(), permanent: false);
    }
  }
}
