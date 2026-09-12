import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../chat/widgets/chat_list_body.dart';
import '../../main_nav/main_tab_nav.dart';
import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../../onboarding/models/user_mode.dart';
import '../../profile/widgets/profile_body.dart';
import '../../wallet/widgets/driver_wallet_body.dart';
import '../controllers/driver_home_controller.dart';
import '../widgets/driver_availability_selector.dart';
import '../widgets/driver_commute_circles_grid.dart';
import '../widgets/driver_mode_pill_selector.dart';
import '../widgets/driver_route_card.dart';
import '../widgets/driver_safety_card.dart';
import '../widgets/driver_set_route_body.dart';
import '../widgets/driver_social_trust_card.dart';
import '../widgets/driver_top_bar.dart';
import '../widgets/driver_trust_setup_card.dart';
import '../widgets/driver_wallet_card.dart';

class DriverHomeView extends GetView<DriverHomeController> {
  const DriverHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const darkBackground = Color(0xFF0D0F11);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: const Color(0xFF0B0D0F),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: darkBackground,
        body: SafeArea(
          bottom: false,
          child: Obx(() {
            final index = controller.selectedNavIndex.value;
            if (index == MainTabNav.findIndex) {
              return const DriverSetRouteBody();
            }
            if (index == MainTabNav.chatIndex) {
              return const ChatListBody();
            }
            if (index == MainTabNav.walletIndex) {
              return const DriverWalletBody();
            }
            if (index == MainTabNav.profileIndex) {
              return const ProfileBody();
            }
            return _DriverHomeContent(controller: controller);
          }),
        ),
        bottomNavigationBar: Obx(
          () => AppModeBottomNav(
            selectedIndex: controller.selectedNavIndex.value,
            onTap: controller.onNavTap,
            isDark: true,
          ),
        ),
      ),
    );
  }
}

class _DriverHomeContent extends StatelessWidget {
  const _DriverHomeContent({required this.controller});

  final DriverHomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final name = controller.displayName;
      final firstName = controller.greetingFirstName;
      final balance = controller.walletBalance.value;
      final status = controller.availabilityStatus.value;
      final circles = controller.commuteCircles;
      final trustPercent = controller.trustReadyPercentage;
      final trustItems = controller.trustItems;

      return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DriverTopBar(
              name: name,
              verificationStatus: 'NOT VERIFIED MEMBER',
              onNotificationTap: controller.openNotifications,
              onMenuTap: controller.openMenu,
            ),
            const SizedBox(height: 20),
            DriverModePillSelector(
              currentMode: UserMode.driver,
              onSelectMode: controller.switchMode,
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome, $firstName',
              style: const TextStyle(
                color: Color(0xFF32E116),
                fontSize: 28,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your driver side is ready to set up.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'One profile. Drive when you want. Receive securely.',
              style: TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 14,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 22),
            DriverWalletCard(
              balance: balance,
              onOpenWallet: controller.openWallet,
            ),
            const SizedBox(height: 18),
            DriverRouteCard(
              controller: controller.routeController,
              onSetRoute: controller.setRoute,
            ),
            const SizedBox(height: 24),
            DriverAvailabilitySelector(
              currentStatus: status,
              onStatusChanged: controller.setAvailability,
            ),
            const SizedBox(height: 28),
            DriverCommuteCirclesGrid(
              circles: circles,
              onViewAll: controller.viewAllCommuteCircles,
              onCircleTap: controller.openCircle,
            ),
            const SizedBox(height: 28),
            DriverSocialTrustCard(
              onPlatformTap: controller.onSocialTapped,
            ),
            const SizedBox(height: 20),
            DriverTrustSetupCard(
              percentage: trustPercent,
              items: trustItems,
              onItemTap: controller.onTrustItemTapped,
            ),
            const SizedBox(height: 20),
            const DriverSafetyCard(),
            const SizedBox(height: 24),
          ],
        ),
      );
    });
  }
}
