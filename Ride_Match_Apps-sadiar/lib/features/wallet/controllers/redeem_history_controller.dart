import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../drawer/controllers/app_drawer_controller.dart';
import '../../drawer/models/drawer_nav_item.dart';
import '../../main_nav/main_tab_nav.dart';
import '../../main_nav/mode_theme.dart';
import '../../onboarding/services/mode_service.dart';
import '../models/redemption_history_model.dart';

class RedeemHistoryController extends GetxController {
  final RxString selectedFilter = 'All'.obs;
  final RxInt selectedNavIndex = 3.obs;

  final RxList<RedemptionHistoryModel> historyItems =
      <RedemptionHistoryModel>[...RedemptionHistoryModel.demoHistory].obs;

  final List<String> categories = const ['All', 'Fuel', 'Coffee', 'Parking'];

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

  List<RedemptionHistoryModel> get filteredItems {
    if (selectedFilter.value == 'All') {
      return historyItems;
    }
    return historyItems
        .where(
          (item) =>
              item.category.toLowerCase() == selectedFilter.value.toLowerCase(),
        )
        .toList();
  }

  void setFilter(String category) {
    selectedFilter.value = category;
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
