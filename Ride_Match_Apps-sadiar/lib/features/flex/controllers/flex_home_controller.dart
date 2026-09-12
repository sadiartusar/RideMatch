import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../auth/models/user_model.dart';
import '../../drawer/controllers/app_drawer_controller.dart';
import '../../drawer/models/drawer_nav_item.dart';
import '../../driver/models/commute_circle_model.dart';
import '../../main_nav/main_tab_nav.dart';
import '../../main_nav/mode_theme.dart';
import '../../onboarding/models/user_mode.dart';
import '../../onboarding/services/mode_service.dart';
import '../../rider/models/coupon_task_model.dart';
import '../../set_destination/controllers/set_destination_controller.dart';

class FlexHomeController extends GetxController {
  FlexHomeController({ModeService? modeService})
      : _modeService = modeService ??
            (Get.isRegistered<ModeService>() ? Get.find<ModeService>() : null);

  final ModeService? _modeService;

  final TextEditingController destinationController = TextEditingController();

  final RxInt walletCoupons = 500.obs;
  final RxInt selectedNavIndex = 0.obs;
  final RxInt verificationPercent = 60.obs;

  final RxList<CommuteCircleModel> commuteCircles =
      RxList<CommuteCircleModel>(CommuteCircleModel.defaults);

  final RxList<CouponTaskModel> couponTasks =
      RxList<CouponTaskModel>(CouponTaskModel.defaults);

  UserModel? get user {
    if (Get.isRegistered<AuthController>()) {
      return Get.find<AuthController>().currentUser.value;
    }
    return null;
  }

  String get displayName {
    final name = user?.name.trim();
    if (name != null && name.isNotEmpty) {
      return name;
    }
    return 'Jeremy M. Ralston';
  }

  String get greetingFirstName {
    final name = user?.name.trim();
    if (name != null && name.isNotEmpty) {
      return name.split(' ').first;
    }
    return 'Alex';
  }

  @override
  void onClose() {
    destinationController.dispose();
    super.onClose();
  }

  Future<void> switchMode(UserMode mode) async {
    if (mode == UserMode.flex) return;
    ModeTheme.resetScopedControllers();
    if (_modeService != null) {
      await _modeService.setMode(mode);
      Get.offAllNamed(_modeService.homeRouteFor(mode));
    } else {
      final route = switch (mode) {
        UserMode.flex => AppRoutes.flexHome,
        UserMode.rider => AppRoutes.riderHome,
        UserMode.driver => AppRoutes.driverHome,
      };
      Get.offAllNamed(route);
    }
  }

  void changeMode() => Get.toNamed(AppRoutes.chooseMode);

  void openRiderFlow() => switchMode(UserMode.rider);

  void openDriverFlow() => switchMode(UserMode.driver);

  void setDestination() {
    final query = destinationController.text.trim();
    SetDestinationController.openFromHome(
      destinationQuery: query.isEmpty ? null : query,
    );
  }

  void openWallet() {
    // Get.bottomSheet(
    //   Container(
    //     padding: const EdgeInsets.all(24),
    //     decoration: const BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    //     ),
    //     child: SafeArea(
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Center(
    //             child: Container(
    //               width: 40,
    //               height: 4,
    //               margin: const EdgeInsets.only(bottom: 20),
    //               decoration: BoxDecoration(
    //                 color: const Color(0xFFE5E7EB),
    //                 borderRadius: BorderRadius.circular(2),
    //               ),
    //             ),
    //           ),
    //           const Text(
    //             'Flex Coupons & Wallet',
    //             style: TextStyle(
    //               fontSize: 20,
    //               fontWeight: FontWeight.w800,
    //               color: Color(0xFF111827),
    //             ),
    //           ),
    //           const SizedBox(height: 6),
    //           const Text(
    //             'Your unified wallet works for ride discounts and driver payouts.',
    //             style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
    //           ),
    //           const SizedBox(height: 20),
    //           Container(
    //             width: double.infinity,
    //             padding: const EdgeInsets.all(20),
    //             decoration: BoxDecoration(
    //               color: const Color(0xFFF0FDF4),
    //               borderRadius: BorderRadius.circular(16),
    //               border: Border.all(color: const Color(0xFFBBF7D0)),
    //             ),
    //             child: Column(
    //               children: [
    //                 const Text(
    //                   'Starter Coupons Balance',
    //                   style: TextStyle(color: Color(0xFF166534), fontSize: 13, fontWeight: FontWeight.w600),
    //                 ),
    //                 const SizedBox(height: 6),
    //                 Text(
    //                   '${walletCoupons.value} Coupons',
    //                   style: const TextStyle(
    //                     fontSize: 32,
    //                     fontWeight: FontWeight.w900,
    //                     color: Color(0xFF15803D),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           const SizedBox(height: 20),
    //           SizedBox(
    //             width: double.infinity,
    //             height: 50,
    //             child: ElevatedButton(
    //               onPressed: () => Get.back(),
    //               style: ElevatedButton.styleFrom(
    //                 backgroundColor: AppColors.button,
    //                 foregroundColor: AppColors.buttonForeground,
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(14),
    //                 ),
    //               ),
    //               child: const Text(
    //                 'Close',
    //                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    Get.toNamed( AppRoutes.flexWallet);
  }

  void openVerificationHub() {
    Get.toNamed(AppRoutes.editProfile);
  }

  void viewAllCommuteCircles() {
    Get.toNamed(AppRoutes.communityCircles);
  }

  void openCircle(CommuteCircleModel circle) {
    Get.toNamed(AppRoutes.communityCircles);
  }

  void onSocialTapped(String platform) {
    Get.snackbar(
      '$platform Connected',
      'Your $platform account is linked to your profile.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void onCouponTaskTapped(CouponTaskModel task) {
    Get.snackbar(
      task.title,
      task.badgeText != null
          ? 'Earn ${task.badgeText} coupons by completing this activity!'
          : 'Share your link to earn coupons when your friend rides.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF166534),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void viewAllCoupons() {
    openWallet();
  }

  void openSafetyDetails() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Row(
                children: [
                  Icon(Icons.crisis_alert_rounded, color: Color(0xFFEF4444), size: 24),
                  SizedBox(width: 10),
                  Text(
                    'Safety First Guarantee',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                '• Real-time GPS sharing with trusted contacts.\n'
                '• Audio trip monitoring with automated collision detection.\n'
                '• Emergency recording shared with emergency responders if needed.\n'
                '• All trip data is encrypted and auto-purged after 48 hours.',
                style: TextStyle(fontSize: 14, height: 1.5, color: Color(0xFF4B5563)),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: AppColors.buttonForeground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Understood'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onNavTap(int index) {
    if (index == MainTabNav.findIndex) {
      SetDestinationController.ensureController();
      if (Get.isRegistered<SetDestinationController>()) {
        Get.find<SetDestinationController>().resetToVibeStep();
      }
    } else if (index == MainTabNav.chatIndex) {
      MainTabNav.ensureChatController();
    } else if (index == MainTabNav.profileIndex) {
      MainTabNav.ensureProfileController();
    }
    selectedNavIndex.value = index;
    switch (index) {
      case 0:
        // Already on Flex Home
        break;
      case 1:
        // Find / Set Destination — shown inside this home shell.
        break;
      case 2:
        // Chat tab — shown inside this home shell (shared bottom nav).
        break;
      case 3:
        // openWallet();
        break;
      case 4:
        // Profile tab — shown inside this home shell (shared bottom nav).
        break;
    }
  }

  void openNotifications() {
    Get.toNamed(AppRoutes.notifications);
  }

  void openMenu() {
    AppDrawerController.open(
      userName: displayName,
      selectedId: selectedNavIndex.value == MainTabNav.profileIndex
          ? DrawerNavId.profile
          : DrawerNavId.home,
      onOpenWallet: openWallet,
      onOpenNotifications: openNotifications,
      onChangeMode: changeMode,
      onLogout: logout,
    );
  }

  Future<void> logout() async {
    if (Get.isRegistered<AuthController>()) {
      await Get.find<AuthController>().logout();
    }
  }
}
