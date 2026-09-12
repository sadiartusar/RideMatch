import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_match/features/flex_wallet/controller/flex_wallet_controller.dart';
import '../../main_nav/main_tab_nav.dart';
import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controller/flex_missions_controller.dart';
import '../widgets/daily_mission_tile.dart';
import '../widgets/missions_progress_card.dart';
import '../widgets/social_mission_banner.dart';
import '../widgets/sponsored_mission_card.dart';

class MissionsView extends GetView<FlexMissionsController> {
  const MissionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E2022)),
          onPressed: () => Get.find<FlexWalletController>().backToWallet(),
        ),
        title: const Text(
          'Missions',
          style: TextStyle(color: Color(0xFF1E2022), fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF333333)),
            onPressed: () => Get.snackbar('Notifications', 'No new alerts'),
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF333333)),
            onPressed: () => Get.snackbar('Menu', 'Mission Options'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MissionsProgressCard(),
              const SizedBox(height: 22),
              const Text(
                "Today's Missions",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E2022)),
              ),
              const SizedBox(height: 12),
              DailyMissionTile(
                icon: Icons.calendar_today_outlined,
                title: 'Daily Check-in',
                subtitle: 'Claim your daily reward',
                points: '+5',
                onTap: controller.onDailyCheckIn,
              ),
              const SizedBox(height: 10),
              DailyMissionTile(
                icon: Icons.eco_outlined,
                title: 'Carbon Hero',
                subtitle: 'Walk 2km today',
                points: '+15',
                onTap: controller.onCarbonHero,
              ),
              const SizedBox(height: 22),
              const Text(
                'Sponsored',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E2022)),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: SponsoredMissionCard(
                      imageUrl: 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=400&q=80',
                      showPlay: true,
                      title: 'Watch & Earn',
                      subtitle: 'Watch the new Bolt AD',
                      reward: '+10 Pts',
                      onTap: controller.onWatchAd,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SponsoredMissionCard(
                      imageUrl: 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?auto=format&fit=crop&w=400&q=80',
                      showPlay: false,
                      title: 'Safety Quiz',
                      subtitle: 'Test your road kn...',
                      reward: '+20 Pts',
                      onTap: () => Get.toNamed('/mission-quiz'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              const Text(
                'Social Missions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E2022)),
              ),
              const SizedBox(height: 12),
              SocialMissionBanner(onInvite: controller.onSendInvite),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: AppModeBottomNav(
      //   selectedIndex: MainTabNav.walletIndex,
      //   onTap: (index) {
      //     if (index == MainTabNav.homeIndex) MainTabNav.showHome();
      //     else if (index == MainTabNav.findIndex) MainTabNav.showRoute();
      //     else if (index == MainTabNav.chatIndex) MainTabNav.showChat();
      //     else if (index == MainTabNav.walletIndex) Get.back();
      //     else if (index == MainTabNav.profileIndex) MainTabNav.showProfile();
      //   },
      // ),
    );
  }
}