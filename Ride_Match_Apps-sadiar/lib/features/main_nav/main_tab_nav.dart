import 'package:get/get.dart';
import 'package:ride_match/features/flex_wallet/controller/flex_wallet_controller.dart';

import '../../core/routes/app_routes.dart';
import '../chat/controllers/chat_list_controller.dart';
import '../driver/controllers/driver_home_controller.dart';
import '../driver/controllers/driver_set_route_controller.dart';
import '../flex/controllers/flex_home_controller.dart';
import '../profile/controllers/profile_controller.dart';
import '../rider/controllers/rider_home_controller.dart';
import '../wallet/controllers/wallet_controller.dart';
import 'mode_theme.dart';

/// Coordinates Home / Route / Chat / Wallet / Profile tabs on the active mode home shell.
class MainTabNav {
  MainTabNav._();

  static const int homeIndex = 0;
  static const int findIndex = 1;
  static const int chatIndex = 2;
  static const int walletIndex = 3;
  static const int profileIndex = 4;

  static bool get isOnHomeShell {
    final route = Get.currentRoute;
    return route == AppRoutes.riderHome ||
        route == AppRoutes.flexHome ||
        route == AppRoutes.driverHome;
  }

  static String? get activeHomeRoute {
    if (Get.isRegistered<DriverHomeController>()) return AppRoutes.driverHome;
    if (Get.isRegistered<FlexHomeController>()) return AppRoutes.flexHome;
    if (Get.isRegistered<RiderHomeController>()) return AppRoutes.riderHome;
    return null;
  }

  static bool get hasHomeController => activeHomeRoute != null;

  static void showHome() {
    _setTab(homeIndex);
    _popToActiveHome();
  }

  static void showFind() {
    showRoute();
  }

  static void showRoute() {
    if (!hasHomeController) {
      Get.toNamed(AppRoutes.driverSetRoute);
      return;
    }

    _ensureDriverSetRouteController();
    if (Get.isRegistered<DriverSetRouteController>()) {
      Get.find<DriverSetRouteController>().currentStep.value =
          DriverSetRouteStep.setup;
    }
    _popToActiveHome();
    _setTab(findIndex);
  }

  static void showChat({bool isDark = false}) {
    if (!hasHomeController) {
      Get.toNamed(
        AppRoutes.chat,
        arguments: {'isDark': ModeTheme.isDark},
      );
      return;
    }

    _ensureChatController();
    _popToActiveHome();
    _setTab(chatIndex);
  }

  static void showWallet({bool isDark = false}) {
     if (Get.isRegistered<FlexHomeController>()) {
      _ensureFlexWalletController();
      Get.toNamed(AppRoutes.flexWallet);
      return;
    }
    if (!hasHomeController) {
      Get.toNamed(
        AppRoutes.wallet,
        arguments: {'isDark': ModeTheme.isDark},
      );
      return;
    }
    _ensureFlexWalletController();
    _ensureWalletController();
    _popToActiveHome();
    _setTab(walletIndex);
  }

  static void showProfile({bool isDark = false}) {
    if (!hasHomeController) {
      Get.toNamed(
        AppRoutes.profile,
        arguments: {'isDark': ModeTheme.isDark},
      );
      return;
    }

    _ensureProfileController();
    _popToActiveHome();
    _setTab(profileIndex);
  }

  static void _setTab(int index) {
    if (Get.isRegistered<RiderHomeController>()) {
      Get.find<RiderHomeController>().selectedNavIndex.value = index;
    }
    if (Get.isRegistered<FlexHomeController>()) {
      Get.find<FlexHomeController>().selectedNavIndex.value = index;
    }
    if (Get.isRegistered<DriverHomeController>()) {
      Get.find<DriverHomeController>().selectedNavIndex.value = index;
    }
  }

  static void _popToActiveHome() {
    final target = activeHomeRoute;
    if (target == null) return;
    if (Get.currentRoute == target) return;

    Get.until(
      (route) => route.settings.name == target || route.isFirst,
    );

    if (Get.currentRoute != target) {
      Get.offNamed(target);
    }
  }

  static void ensureProfileController() {
    if (!Get.isRegistered<ProfileController>()) {
      Get.put(ProfileController(), permanent: false);
    }
  }

  static void ensureChatController() {
    if (!Get.isRegistered<ChatListController>()) {
      Get.put(ChatListController(), permanent: false);
    }
  }

  static void ensureWalletController() {
    if (!Get.isRegistered<WalletController>()) {
      Get.put(WalletController(), permanent: false);
    }
  }

  static void ensureDriverSetRouteController() {
    if (!Get.isRegistered<DriverSetRouteController>()) {
      Get.put(DriverSetRouteController(), permanent: false);
    }
  }

  static void ensureFlexWalletController() {
    if (!Get.isRegistered<FlexWalletController>()) {
      Get.put(FlexWalletController(), permanent: false);
    }
  }

   static void _ensureFlexWalletController() => ensureFlexWalletController();

  static void _ensureProfileController() => ensureProfileController();

  static void _ensureChatController() => ensureChatController();

  static void _ensureWalletController() => ensureWalletController();

  static void _ensureDriverSetRouteController() => ensureDriverSetRouteController();
}
