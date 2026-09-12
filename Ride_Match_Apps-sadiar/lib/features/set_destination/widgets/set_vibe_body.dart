import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../rider/widgets/rider_safety_card.dart';
import '../../rider/widgets/rider_top_bar.dart';
import '../controllers/set_destination_controller.dart';
import '../models/vibe_preferences_model.dart';
import 'vibe_commute_circles_grid.dart';
import 'vibe_option_chip.dart';
import 'vibe_social_trust_card.dart';

/// Daily check-in / "Set your vibe" — first step from home Set Destination.
class SetVibeBody extends GetView<SetDestinationController> {
  const SetVibeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Obx(() {
                final mood = controller.selectedMood.value;
                final music = controller.selectedMusic.value;
                final intent = controller.selectedIntent.value;
                final circleId = controller.selectedCircleId.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RiderTopBar(
                      name: controller.displayName,
                      verificationStatus: 'VERIFIED MEMBER',
                      onNotificationTap: controller.openNotifications,
                      onMenuTap: controller.openMenu,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accentSoft,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'DAILY CHECK-IN',
                        style: TextStyle(
                          color: Color(0xFF15803D),
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Set your vibe',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.6,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Customize your journey and curate your social experience today.',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 22),
                    const VibeSectionLabel('Mood'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: VibeOptionChip(
                            label: 'Quiet',
                            icon: Icons.remove_circle_outline_rounded,
                            selected: mood == VibeMood.quiet,
                            onTap: () => controller.selectMood(VibeMood.quiet),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: VibeOptionChip(
                            label: 'Open to Conversation',
                            icon: Icons.chat_bubble_outline_rounded,
                            selected: mood == VibeMood.openToConversation,
                            onTap: () => controller
                                .selectMood(VibeMood.openToConversation),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const VibeSectionLabel('Music'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        VibePillChip(
                          label: 'Music On',
                          icon: Icons.volume_up_rounded,
                          selected: music == VibeMusic.on,
                          onTap: () => controller.selectMusic(VibeMusic.on),
                        ),
                        const SizedBox(width: 12),
                        VibePillChip(
                          label: 'Music Off',
                          icon: Icons.volume_off_rounded,
                          selected: music == VibeMusic.off,
                          onTap: () => controller.selectMusic(VibeMusic.off),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const VibeSectionLabel('Intent'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: VibeOptionChip(
                            label: 'Networking',
                            icon: Icons.work_outline_rounded,
                            selected: intent == VibeIntent.networking,
                            onTap: () =>
                                controller.selectIntent(VibeIntent.networking),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: VibeOptionChip(
                            label: 'Socializing',
                            icon: Icons.groups_outlined,
                            selected: intent == VibeIntent.socializing,
                            onTap: () =>
                                controller.selectIntent(VibeIntent.socializing),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    VibeCommuteCirclesGrid(
                      circles: controller.commuteCircles,
                      selectedId: circleId,
                      onCircleTap: controller.selectCircle,
                      onShowAll: controller.showAllCircles,
                    ),
                    const SizedBox(height: 22),
                    const VibeSocialTrustCard(),
                    const SizedBox(height: 18),
                    RiderSafetyCard(
                      onLearnMore: controller.openSafetyDetails,
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              }),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: controller.continueFromVibe,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
