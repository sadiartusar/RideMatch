import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../auth/models/user_model.dart';
import '../../drawer/controllers/app_drawer_controller.dart';
import '../../drawer/models/drawer_nav_item.dart';
import '../../driver/controllers/driver_set_route_controller.dart';
import '../../main_nav/main_tab_nav.dart';
import '../../main_nav/mode_theme.dart';
import '../../onboarding/services/mode_service.dart';
import '../models/profile_model.dart';

class ProfileController extends GetxController {
  ProfileController({this.isDarkMode});

  /// Optional override when ModeService is unavailable.
  final bool? isDarkMode;

  final RxBool verifiedOnly = true.obs;

  late final ProfileModel profile;

  /// Always follow the active mode theme (Driving = dark).
  bool get isDark {
    if (Get.isRegistered<ModeService>()) {
      return ModeTheme.isDark;
    }
    return isDarkMode == true;
  }

  @override
  void onInit() {
    super.onInit();
    profile = ProfileModel.demo;
    verifiedOnly.value = profile.verifiedOnly;
  }

  UserModel? get user {
    if (Get.isRegistered<AuthController>()) {
      return Get.find<AuthController>().currentUser.value;
    }
    return null;
  }

  String get displayName {
    final name = user?.name.trim();
    if (name != null && name.isNotEmpty) return name;
    return profile.name;
  }

  void goBack() {
    if (Get.isRegistered<DriverSetRouteController>() &&
        Get.find<DriverSetRouteController>().currentStep.value ==
            DriverSetRouteStep.profile) {
      Get.find<DriverSetRouteController>().backFromProfile();
      return;
    }
    if (MainTabNav.isOnHomeShell) {
      MainTabNav.showHome();
      return;
    }
    Get.back();
  }

  void openNotifications() {
    Get.toNamed(
      AppRoutes.notifications,
      arguments: {'isDark': isDark},
    );
  }

  void openMenu() {
    AppDrawerController.open(
      userName: displayName,
      selectedId: DrawerNavId.profile,
      isDark: isDark,
      onOpenNotifications: openNotifications,
      onChangeMode: () => Get.toNamed(AppRoutes.chooseMode),
      onLogout: logout,
    );
  }

  void toggleVerifiedOnly(bool value) => verifiedOnly.value = value;

  void openWallet() {
    Get.snackbar(
      'Wallet',
      'Wallet details are coming soon.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void editProfile() {
    Get.toNamed(
      AppRoutes.editProfile,
      arguments: {'isDark': isDark},
    );
  }

  void openRideIdentity() => Get.toNamed(AppRoutes.connectModeFilter);

  void openMissions() => _comingSoon('My Missions');

  void openRideHistory() => _comingSoon('Ride History');

  void openSettings() {
    Get.toNamed(
      AppRoutes.settings,
      arguments: {'isDark': isDark},
    );
  }

  void onSocialTap(ProfileSocialLink link) => _comingSoon(link.label);

  final RxInt selectedNavIndex = 4.obs;

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
      // already on profile
      return;
    }
    selectedNavIndex.value = index;
  }

  Future<void> logout() async {
    if (Get.isRegistered<AuthController>()) {
      await Get.find<AuthController>().logout();
    }
  }

  void _comingSoon(String label) {
    Get.snackbar(
      label,
      '$label is coming soon.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
