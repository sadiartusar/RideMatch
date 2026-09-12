import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../chat/widgets/chat_list_body.dart';
import '../../main_nav/main_tab_nav.dart';
import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../../onboarding/models/user_mode.dart';
import '../../profile/widgets/profile_body.dart';
import '../../set_destination/widgets/set_destination_body.dart';
import '../controllers/rider_home_controller.dart';
import '../widgets/rider_commute_circles_grid.dart';
import '../widgets/rider_destination_card.dart';
import '../widgets/rider_earn_coupons_card.dart';
import '../widgets/rider_mode_pill_selector.dart';
import '../widgets/rider_quote_card.dart';
import '../widgets/rider_safety_card.dart';
import '../widgets/rider_social_trust_card.dart';
import '../widgets/rider_top_bar.dart';
import '../widgets/rider_verification_card.dart';
import '../widgets/rider_welcome_offer_card.dart';

class RiderHomeView extends GetView<RiderHomeController> {
  const RiderHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: Obx(() {
            final index = controller.selectedNavIndex.value;
            if (index == MainTabNav.findIndex) {
              return const SetDestinationBody();
            }
            if (index == MainTabNav.chatIndex) {
              return const ChatListBody();
            }
            if (index == MainTabNav.profileIndex) {
              return const ProfileBody();
            }
            return _RiderHomeContent(controller: controller);
          }),
        ),
        bottomNavigationBar: Obx(
          () => AppModeBottomNav(
            selectedIndex: controller.selectedNavIndex.value,
            onTap: controller.onNavTap,
          ),
        ),
      ),
    );
  }
}

class _RiderHomeContent extends StatelessWidget {
  const _RiderHomeContent({required this.controller});

  final RiderHomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final name = controller.displayName;
      final firstName = controller.greetingFirstName;
      final coupons = controller.walletCoupons.value;
      final circles = controller.commuteCircles;
      final tasks = controller.couponTasks;
      final verification = controller.verificationPercent.value;

      return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RiderTopBar(
              name: name,
              verificationStatus: 'VERIFIED MEMBER',
              onNotificationTap: controller.openNotifications,
              onMenuTap: controller.openMenu,
            ),
            const SizedBox(height: 20),
            RiderModePillSelector(
              currentMode: UserMode.rider,
              onSelectMode: controller.switchMode,
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome, $firstName',
              style: const TextStyle(
                color: Color(0xFF111827),
                fontSize: 28,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'One profile. Three states. Real-time mobility.',
              style: TextStyle(
                color: Color(0xFF15803D),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 18),
            const RiderQuoteCard(),
            const SizedBox(height: 20),
            RiderWelcomeOfferCard(
              couponCount: coupons,
              onOpenWallet: controller.openWallet,
            ),
            const SizedBox(height: 20),
            RiderDestinationCard(
              controller: controller.destinationController,
              onSetDestination: controller.setDestination,
            ),
            const SizedBox(height: 22),
            RiderVerificationCard(
              percentage: verification,
              statusBadge: verification >= 100 ? 'VERIFIED' : 'PENDING',
              onCompleteId: controller.openVerificationHub,
            ),
            const SizedBox(height: 24),
            RiderCommuteCirclesGrid(
              circles: circles,
              onViewAll: controller.viewAllCommuteCircles,
              onCircleTap: controller.openCircle,
            ),
            const SizedBox(height: 24),
            RiderSocialTrustCard(
              onPlatformTap: controller.onSocialTapped,
            ),
            const SizedBox(height: 24),
            RiderEarnCouponsCard(
              tasks: tasks,
              onViewAll: controller.viewAllCoupons,
              onTaskTap: controller.onCouponTaskTapped,
            ),
            const SizedBox(height: 24),
            RiderSafetyCard(
              onLearnMore: controller.openSafetyDetails,
            ),
            const SizedBox(height: 24),
          ],
        ),
      );
    });
  }
}
