import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../drawer/controllers/app_drawer_controller.dart';
import '../../drawer/models/drawer_nav_item.dart';
import '../../main_nav/main_tab_nav.dart';
import '../../main_nav/mode_theme.dart';
import '../../onboarding/services/mode_service.dart';
import '../models/wallet_model.dart';

class WalletController extends GetxController {
  final Rx<DriverWalletModel> driverWallet = DriverWalletModel.demo.obs;
  Rx<DriverWalletModel> get wallet => driverWallet;

  final RxInt selectedNavIndex = 3.obs;
  final RxBool isPushedFromOtherScreen = false.obs;

  @override
  void onInit() {
    super.onInit();
    
    if (Get.arguments is Map && Get.arguments['isPushed'] != null) {
      isPushedFromOtherScreen.value = Get.arguments['isPushed'];
    }
  }

  bool get isDark {
    if (Get.isRegistered<ModeService>()) {
      return ModeTheme.isDark;
    }
    return true;
  }

  void handleBackAction() {
    if (isPushedFromOtherScreen.value) {
    
      Get.back();
    } else {
      
      MainTabNav.showHome();
    }
  }

  String get displayName {
    if (Get.isRegistered<AuthController>()) {
      final name = Get.find<AuthController>().currentUser.value?.name;
      if (name != null && name.isNotEmpty) return name;
    }
    return 'Marcus Miller';
  }

  void goToMarketplace() {
    Get.toNamed(AppRoutes.marketplace);
  }

  void openMarketplace() => goToMarketplace();

  void goToRedeemHistory() {
    Get.toNamed(AppRoutes.redeemHistory);
  }

  void openOffer(WalletOfferItem offer) {
    Get.toNamed(AppRoutes.marketplace);
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
      onLogout: () async {
        if (Get.isRegistered<AuthController>()) {
          await Get.find<AuthController>().logout();
        }
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
      MainTabNav.showChat(isDark: isDark);
      return;
    }
    if (index == 3) {
      // already on wallet
      return;
    }
    if (index == MainTabNav.profileIndex) {
      MainTabNav.showProfile(isDark: isDark);
      return;
    }
    selectedNavIndex.value = index;
  }
}
