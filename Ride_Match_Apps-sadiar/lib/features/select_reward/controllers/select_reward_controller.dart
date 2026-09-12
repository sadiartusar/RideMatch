import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../auth/models/user_model.dart';
import '../../drawer/controllers/app_drawer_controller.dart';
import '../../drawer/models/drawer_nav_item.dart';
import '../../main_nav/main_tab_nav.dart';
import '../models/reward_option.dart';

class SelectRewardController extends GetxController {
  final RxInt selectedNavIndex = MainTabNav.findIndex.obs;
  final RxInt couponsAvailable = 500.obs;
  final RxnInt selectedVoucherDollars = RxnInt(12);
  final RxnString selectedRewardId = RxnString('starbucks');

  final List<VoucherAmount> vouchers = VoucherAmount.defaults;
  final List<RewardOption> merchantRewards = RewardOption.merchants;
  final RewardOption specialOffer = RewardOption.specialOffer;

  UserModel? get user {
    if (Get.isRegistered<AuthController>()) {
      return Get.find<AuthController>().currentUser.value;
    }
    return null;
  }

  String get displayName {
    final name = user?.name.trim();
    if (name != null && name.isNotEmpty) return name;
    return 'Jeremy M. Ralston';
  }

  void goBack() => Get.back();

  void selectVoucher(int dollars) {
    if (selectedVoucherDollars.value == dollars) {
      selectedVoucherDollars.value = null;
    } else {
      selectedVoucherDollars.value = dollars;
    }
  }

  void selectReward(String id) {
    selectedRewardId.value = id;
  }

  void offerThisReward() {
    Get.toNamed(
      AppRoutes.matchList,
      arguments: {
        'rewardId': selectedRewardId.value,
        'voucherDollars': selectedVoucherDollars.value,
      },
    );
  }

  void openNotifications() {
    Get.toNamed(AppRoutes.notifications);
  }

  void openMenu() {
    AppDrawerController.open(
      userName: displayName,
      selectedId: DrawerNavId.home,
      onOpenNotifications: openNotifications,
      onChangeMode: () => Get.toNamed(AppRoutes.chooseMode),
    );
  }

  void onNavTap(int index) {
    selectedNavIndex.value = index;
    switch (index) {
      case MainTabNav.homeIndex:
        MainTabNav.showHome();
        break;
      case MainTabNav.findIndex:
        break;
      case MainTabNav.chatIndex:
        MainTabNav.showChat();
        break;
      case 3:
        Get.toNamed(AppRoutes.wallet);
        break;
      case MainTabNav.profileIndex:
        MainTabNav.showProfile();
        break;
    }
  }
}
