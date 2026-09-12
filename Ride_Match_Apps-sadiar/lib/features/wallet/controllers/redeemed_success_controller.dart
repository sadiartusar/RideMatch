import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../main_nav/main_tab_nav.dart';
import '../models/marketplace_coupon_model.dart';
import '../models/redemption_history_model.dart';

class RedeemedSuccessController extends GetxController {
  late final RedemptionHistoryModel redemptionItem;
  final RxInt selectedNavIndex = 3.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is RedemptionHistoryModel) {
      redemptionItem = args;
    } else if (args is Map && args['receipt'] is RedemptionHistoryModel) {
      redemptionItem = args['receipt'] as RedemptionHistoryModel;
    } else if (args is Map && args['partner'] is MarketplacePartnerModel) {
      final p = args['partner'] as MarketplacePartnerModel;
      redemptionItem = RedemptionHistoryModel(
        orderId: '#TXN-90210-RM',
        title: p.title,
        merchant: '${p.title} (Hydrogen Hub)',
        dateTimeLabel: 'Oct 24, 2023 • 22:45',
        valueLabel: '\$15.00',
        status: 'COMPLETED',
        category: p.category,
      );
    } else {
      redemptionItem = RedemptionHistoryModel.demoHistory.first;
    }
  }

  void goToHistory() {
    Get.toNamed(AppRoutes.redeemHistory);
  }

  void backToMarketplace() {
    Get.offNamedUntil(
      AppRoutes.marketplace,
      (route) => route.settings.name == AppRoutes.wallet || route.isFirst,
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
