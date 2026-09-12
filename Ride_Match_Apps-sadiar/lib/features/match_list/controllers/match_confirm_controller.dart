import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../main_nav/main_tab_nav.dart';
import '../../rider/controllers/rider_home_controller.dart';
import '../models/driver_match_model.dart';

class MatchConfirmController extends GetxController {
  late final DriverMatchModel match;
  String? offeredRewardId;
  int? voucherDollars;
  final RxInt selectedNavIndex = MainTabNav.findIndex.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map) {
      offeredRewardId = args['rewardId'] as String?;
      voucherDollars = args['voucherDollars'] as int?;
      if (args['match'] is DriverMatchModel) {
        match = args['match'] as DriverMatchModel;
      } else {
        match = DriverMatchModel.defaultMatches.first;
      }
    } else {
      match = DriverMatchModel.defaultMatches.first;
    }
  }

  void goBack() => Get.back();

  void openPreMatchChat() {
    Get.toNamed(
      AppRoutes.preMatchChat,
      arguments: {
        'match': match,
        'rewardId': offeredRewardId,
        'voucherDollars': voucherDollars,
      },
    );
  }

  void viewFullProfile() {
    Get.toNamed(
      AppRoutes.userProfile,
      arguments: {
        'match': match,
        'rewardId': offeredRewardId,
        'voucherDollars': voucherDollars,
      },
    );
  }

  void continueFlow() => Get.back();

  void onNavTap(int index) {
    selectedNavIndex.value = index;
    switch (index) {
      case MainTabNav.homeIndex:
        MainTabNav.showHome();
        break;
      case MainTabNav.findIndex:
        Get.back();
        break;
      case MainTabNav.chatIndex:
        MainTabNav.showChat();
        break;
      case 3:
        if (Get.isRegistered<RiderHomeController>()) {
          Get.find<RiderHomeController>().openWallet();
        } else {
          Get.toNamed(AppRoutes.wallet);
        }
        break;
      case MainTabNav.profileIndex:
        MainTabNav.showProfile();
        break;
    }
  }
}
