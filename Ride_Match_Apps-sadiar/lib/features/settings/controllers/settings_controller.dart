import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../drawer/controllers/app_drawer_controller.dart';
import '../../drawer/models/drawer_nav_item.dart';
import '../../main_nav/mode_theme.dart';

class SettingsController extends GetxController {
  bool get isDark => ModeTheme.isDark;

  final RxBool notificationsEnabled = true.obs;
  final RxString language = 'English'.obs;
  final RxString profileVisibility = 'Matches only'.obs;

  void goBack() => Get.back();

  void openNotifications() {
    Get.toNamed(
      AppRoutes.notifications,
      arguments: {'isDark': isDark},
    );
  }

  void openMenu() {
    final name = Get.isRegistered<AuthController>()
        ? (Get.find<AuthController>().currentUser.value?.name ?? 'Member')
        : 'Member';

    AppDrawerController.open(
      userName: name.isEmpty ? 'Member' : name,
      selectedId: DrawerNavId.settings,
      isDark: isDark,
      onOpenNotifications: openNotifications,
      onChangeMode: () => Get.toNamed(AppRoutes.chooseMode),
      onLogout: logout,
    );
  }

  void toggleNotifications(bool value) => notificationsEnabled.value = value;

  void openLanguage() {
    final options = ['English', 'Spanish', 'French', 'Hebrew'];
    final currentIndex = options.indexOf(language.value);
    final next = options[(currentIndex + 1) % options.length];
    language.value = next;
  }

  void openProfileVisibility() {
    final options = ['Matches only', 'Verified members', 'Everyone', 'Private'];
    final currentIndex = options.indexOf(profileVisibility.value);
    final next = options[(currentIndex + 1) % options.length];
    profileVisibility.value = next;
  }

  void openTerms() => _comingSoon('Terms of Service');

  void openHelpCenter() => _comingSoon('Help Center');

  void deleteAccount() {
    Get.defaultDialog(
      title: 'Delete Account',
      middleText:
          'This will permanently delete your Ride Match account. This action cannot be undone.',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFFDC2626),
      onConfirm: () async {
        Get.back();
        await logout();
      },
    );
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
