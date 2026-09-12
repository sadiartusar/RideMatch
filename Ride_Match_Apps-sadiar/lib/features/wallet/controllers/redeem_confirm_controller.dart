import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../drawer/controllers/app_drawer_controller.dart';
import '../../drawer/models/drawer_nav_item.dart';
import '../../main_nav/main_tab_nav.dart';
import '../../main_nav/mode_theme.dart';
import '../../onboarding/services/mode_service.dart';
import '../models/marketplace_coupon_model.dart';
import '../models/redemption_history_model.dart';

class RedeemConfirmController extends GetxController {
  late final MarketplacePartnerModel partner;
  final RxBool isRedeeming = false.obs;
  final RxInt selectedNavIndex = 3.obs;

  final int currentCouponBalance = 850;
  final String serviceFee = 'FREE';
  final String driverNetBenefit = '\$15.00';

  bool get isDark {
    if (Get.isRegistered<ModeService>()) {
      return ModeTheme.isDark;
    }
    return true;
  }

  String get displayName {
    if (Get.isRegistered<AuthController>()) {
      final name = Get.find<AuthController>().currentUser.value?.name;
      if (name != null && name.isNotEmpty) return name;
    }
    return 'Marcus Miller';
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map && args['partner'] is MarketplacePartnerModel) {
      partner = args['partner'] as MarketplacePartnerModel;
    } else if (args is MarketplacePartnerModel) {
      partner = args;
    } else {
      partner = MarketplacePartnerModel.demoPartners.first;
    }
  }

  void cancel() => Get.back();

  void openNotifications() {
    Get.toNamed(
      AppRoutes.notifications,
      arguments: {'isDark': isDark},
    );
  }

  void openMenu() {
    AppDrawerController.open(
      userName: displayName,
      selectedId: DrawerNavId.marketplace,
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

  void confirmRedemption() {
    isRedeeming.value = true;
    Future.delayed(const Duration(milliseconds: 600), () {
      isRedeeming.value = false;
      final receipt = RedemptionHistoryModel(
        orderId: '#TXN-90210-RM',
        title: partner.title,
        merchant: '${partner.title} (Hydrogen Hub)',
        dateTimeLabel: 'Oct 24, 2023 • 22:45',
        valueLabel: driverNetBenefit,
        status: 'COMPLETED',
        category: partner.category,
      );
      Get.offNamed(
        AppRoutes.redeemedSuccess,
        arguments: {'receipt': receipt},
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
}
