import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main_nav/main_tab_nav.dart';
import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controller/flex_missions_controller.dart';
import '../controller/flex_wallet_controller.dart';
import '../widgets/mission_completed_badge.dart';

class QuizCompletedView extends GetView<FlexMissionsController> {
  const QuizCompletedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final walletController = Get.isRegistered<FlexWalletController>() ? Get.find<FlexWalletController>() : null;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F8F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E2022)),
          onPressed: controller.onBackToMissions,
        ),
        title: const Text(
          'Mission',
          style: TextStyle(color: Color(0xFF1E2022), fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Text(
                'Mission Complete!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
              ),
              const SizedBox(height: 4),
              const Text(
                'Phenomenal work on the field today.',
                style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
              const SizedBox(height: 28),
              Obx(() => MissionCompletedBadge(couponsEarned: controller.earnedQuizReward.value)),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Column(
                  children: [
                    const Text(
                      'TOTAL WALLET BALANCE',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF9CA3AF)),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      walletController != null ? walletController.totalCoupons.value.toString() : '1250',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF111827)),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: controller.onClaimNextReward,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00E63D),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Claim Next Reward', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.onBackToMissions,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE5E7EB),
                    foregroundColor: const Color(0xFF374151),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text(
                    'BACK TO MISSIONS',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppModeBottomNav(
        selectedIndex: MainTabNav.walletIndex,
        onTap: (index) {
          if (index == MainTabNav.homeIndex) MainTabNav.showHome();
          else if (index == MainTabNav.findIndex) MainTabNav.showRoute();
          else if (index == MainTabNav.chatIndex) MainTabNav.showChat();
          else if (index == MainTabNav.walletIndex) MainTabNav.showWallet();
          else if (index == MainTabNav.profileIndex) MainTabNav.showProfile();
        },
      ),
    );
  }
}