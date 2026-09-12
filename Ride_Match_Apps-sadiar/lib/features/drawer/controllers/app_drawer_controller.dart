import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../main_nav/main_tab_nav.dart';
import '../models/drawer_nav_item.dart';
import '../widgets/app_drawer.dart';

/// Shared drawer actions used by Rider / Flex / Driver home menus.
class AppDrawerController {
  AppDrawerController._();

  static void open({
    required String userName,
    bool isVerified = true,
    String? avatarUrl,
    DrawerNavId selectedId = DrawerNavId.home,
    bool isDark = false,
    VoidCallback? onOpenWallet,
    VoidCallback? onOpenNotifications,
    VoidCallback? onChangeMode,
    Future<void> Function()? onLogout,
  }) {
    showAppDrawer(
      userName: userName,
      isVerified: isVerified,
      avatarUrl: avatarUrl,
      selectedId: selectedId,
      isDark: isDark,
      onItemSelected: (id) => _handleSelection(
        id,
        isDark: isDark,
        onOpenWallet: onOpenWallet,
        onOpenNotifications: onOpenNotifications,
        onChangeMode: onChangeMode,
        onLogout: onLogout,
      ),
    );
  }

  static Future<void> _handleSelection(
    DrawerNavId id, {
    bool isDark = false,
    VoidCallback? onOpenWallet,
    VoidCallback? onOpenNotifications,
    VoidCallback? onChangeMode,
    Future<void> Function()? onLogout,
  }) async {
    switch (id) {
      case DrawerNavId.home:
        MainTabNav.showHome();
        return;
      case DrawerNavId.wallet:
        if (onOpenWallet != null) {
          onOpenWallet();
        } else {
          Get.toNamed(AppRoutes.wallet);
        }
        return;
      case DrawerNavId.marketplace:
        Get.toNamed(AppRoutes.marketplace);
        return;
      case DrawerNavId.notifications:
        if (onOpenNotifications != null) {
          onOpenNotifications();
        } else {
          Get.toNamed(
            AppRoutes.notifications,
            arguments: {'isDark': isDark},
          );
        }
        return;
      case DrawerNavId.profile:
        MainTabNav.showProfile(isDark: isDark);
        return;
      case DrawerNavId.settings:
        Get.toNamed(
          AppRoutes.settings,
          arguments: {'isDark': isDark},
        );
        return;
      case DrawerNavId.logout:
        if (onLogout != null) {
          await onLogout();
        } else if (Get.isRegistered<AuthController>()) {
          await Get.find<AuthController>().logout();
        }
        return;
      case DrawerNavId.communityCircles:
        Get.toNamed(AppRoutes.communityCircles);
        return;
      case DrawerNavId.connections:
        Get.toNamed(AppRoutes.connections);
        return;
      case DrawerNavId.missions:
      case DrawerNavId.friendsFeed:
      case DrawerNavId.rideHistory:
      case DrawerNavId.language:
        _comingSoon(_labelFor(id));
        return;
    }
  }

  static String _labelFor(DrawerNavId id) {
    return switch (id) {
      DrawerNavId.missions => 'Missions',
      DrawerNavId.connections => 'Connections',
      DrawerNavId.friendsFeed => 'Friends Feed',
      DrawerNavId.communityCircles => 'Community Circles',
      DrawerNavId.rideHistory => 'Ride History',
      DrawerNavId.marketplace => 'Marketplace',
      DrawerNavId.language => 'Language',
      _ => 'This screen',
    };
  }

  static void _comingSoon(String label) {
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
