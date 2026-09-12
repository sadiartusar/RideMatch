import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../drawer/controllers/app_drawer_controller.dart';
import '../../drawer/models/drawer_nav_item.dart';
import '../../main_nav/main_tab_nav.dart';
import '../../main_nav/mode_theme.dart';
import '../../onboarding/services/mode_service.dart';
import '../models/marketplace_coupon_model.dart';

class MarketplaceCategoryItem {
  const MarketplaceCategoryItem({
    required this.name,
    required this.iconType,
  });

  final String name;
  final String iconType;
}

class MarketplaceController extends GetxController {
  final RxString selectedCategory = 'All'.obs;
  final RxInt selectedNavIndex = 3.obs;

  final int totalCoupons = 1250;
  final int availableCoupons = 850;
  final int expiringCoupons = 400;

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

  final List<MarketplaceCategoryItem> categoryItems = const [
    MarketplaceCategoryItem(name: 'FUEL', iconType: 'fuel'),
    MarketplaceCategoryItem(name: 'PARKING', iconType: 'parking'),
    MarketplaceCategoryItem(name: 'COFFEE', iconType: 'coffee'),
    MarketplaceCategoryItem(name: 'WASH', iconType: 'wash'),
  ];

  final RxList<MarketplacePartnerModel> allPartners =
      RxList<MarketplacePartnerModel>(MarketplacePartnerModel.demoPartners);

  final RxList<MarketplacePartnerModel> expiringDeals =
      RxList<MarketplacePartnerModel>(MarketplacePartnerModel.expiringSoonDeals);

  List<MarketplacePartnerModel> get filteredPartners {
    if (selectedCategory.value == 'All') return allPartners;
    final matches = allPartners
        .where((p) => p.category.toUpperCase() == selectedCategory.value.toUpperCase())
        .toList();
    if (matches.isEmpty) {
      return allPartners;
    }
    return matches;
  }

  void selectCategory(String cat) {
    if (selectedCategory.value.toUpperCase() == cat.toUpperCase()) {
      selectedCategory.value = 'All';
    } else {
      selectedCategory.value = cat;
    }
  }

  void openPartnerDetail(MarketplacePartnerModel partner) {
    Get.toNamed(
      AppRoutes.couponDetail,
      arguments: {'partner': partner},
    );
  }

  void openHistory() {
    Get.toNamed(AppRoutes.redeemHistory);
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
