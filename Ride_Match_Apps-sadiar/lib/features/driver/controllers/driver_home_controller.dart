import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../auth/models/user_model.dart';
import '../../drawer/controllers/app_drawer_controller.dart';
import '../../drawer/models/drawer_nav_item.dart';
import '../../main_nav/main_tab_nav.dart';
import '../../main_nav/mode_theme.dart';
import '../../onboarding/models/user_mode.dart';
import '../../onboarding/services/mode_service.dart';
import '../models/commute_circle_model.dart';
import '../models/driver_availability_status.dart';
import '../models/driver_trust_item_model.dart';
import 'driver_set_route_controller.dart';

class DriverHomeController extends GetxController {
  DriverHomeController({ModeService? modeService})
      : _modeService = modeService ??
            (Get.isRegistered<ModeService>() ? Get.find<ModeService>() : null);

  final ModeService? _modeService;

  final Rx<DriverAvailabilityStatus> availabilityStatus =
      DriverAvailabilityStatus.available.obs;

  final TextEditingController routeController = TextEditingController();

  final RxString walletBalance = '0'.obs;
  final RxInt selectedNavIndex = 0.obs;

  final RxList<CommuteCircleModel> commuteCircles =
      RxList<CommuteCircleModel>(CommuteCircleModel.defaults);

  final RxList<DriverTrustItemModel> trustItems =
      RxList<DriverTrustItemModel>(DriverTrustItemModel.initialItems);

  int get trustReadyPercentage {
    if (trustItems.isEmpty) return 0;
    final completedCount = trustItems.where((item) => item.isCompleted).length;
    return ((completedCount / trustItems.length) * 100).round();
  }

  UserModel? get user {
    if (Get.isRegistered<AuthController>()) {
      return Get.find<AuthController>().currentUser.value;
    }
    return null;
  }

  String get displayName {
    final name = user?.name.trim();
    if (name != null && name.isNotEmpty) {
      return name;
    }
    return 'Jeremy M. Ralston';
  }

  String get greetingFirstName {
    final name = user?.name.trim();
    if (name != null && name.isNotEmpty) {
      return name.split(' ').first;
    }
    return 'Alex';
  }

  @override
  void onClose() {
    routeController.dispose();
    super.onClose();
  }

  Future<void> switchMode(UserMode mode) async {
    if (mode == UserMode.driver) return;
    ModeTheme.resetScopedControllers();
    if (_modeService != null) {
      await _modeService.setMode(mode);
      Get.offAllNamed(_modeService.homeRouteFor(mode));
    } else {
      final route = switch (mode) {
        UserMode.flex => AppRoutes.flexHome,
        UserMode.rider => AppRoutes.riderHome,
        UserMode.driver => AppRoutes.driverHome,
      };
      Get.offAllNamed(route);
    }
  }

  void changeMode() => Get.toNamed(AppRoutes.chooseMode);

  void setAvailability(DriverAvailabilityStatus status) {
    availabilityStatus.value = status;
    Get.snackbar(
      'Status Updated',
      'You are now ${status.label} (${status.subtitle})',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1E2125),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void setRoute() {
    if (Get.isRegistered<DriverSetRouteController>()) {
      Get.find<DriverSetRouteController>().currentStep.value =
          DriverSetRouteStep.setup;
    }
    onNavTap(MainTabNav.findIndex);
  }

  void openWallet() {
    onNavTap(MainTabNav.walletIndex);
  }

  void viewAllCommuteCircles() {
    Get.toNamed(AppRoutes.communityCircles);
  }

  void openCircle(CommuteCircleModel circle) {
    Get.toNamed(AppRoutes.communityCircles);
  }

  void onTrustItemTapped(DriverTrustItemModel item) {
    if (item.isCompleted) {
      Get.snackbar(
        'Verified',
        '${item.label} is already completed and verified.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF16381D),
        colorText: const Color(0xFF32E116),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    // Continue profile completion in Edit Profile.
    Get.toNamed(
      AppRoutes.editProfile,
      arguments: {'isDark': true},
    );
  }

  void onSocialTapped(String platform) {
    Get.snackbar(
      '$platform Connected',
      'Your $platform account is linked to your driver profile.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1E2125),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void onNavTap(int index) {
    if (index == MainTabNav.findIndex) {
      MainTabNav.ensureDriverSetRouteController();
    } else if (index == MainTabNav.chatIndex) {
      MainTabNav.ensureChatController();
    } else if (index == MainTabNav.walletIndex) {
      MainTabNav.ensureWalletController();
    } else if (index == MainTabNav.profileIndex) {
      MainTabNav.ensureProfileController();
    }
    selectedNavIndex.value = index;
  }

  void openNotifications() {
    Get.toNamed(AppRoutes.notifications, arguments: {'isDark': true});
  }

  void openMenu() {
    AppDrawerController.open(
      userName: displayName,
      selectedId: selectedNavIndex.value == MainTabNav.profileIndex
          ? DrawerNavId.profile
          : DrawerNavId.home,
      isDark: true,
      onOpenWallet: openWallet,
      onOpenNotifications: openNotifications,
      onChangeMode: changeMode,
      onLogout: logout,
    );
  }

  Future<void> logout() async {
    if (Get.isRegistered<AuthController>()) {
      await Get.find<AuthController>().logout();
    }
  }
}
