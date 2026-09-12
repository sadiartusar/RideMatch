import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/create_mode_controller.dart';
import 'ai_matchmaking_banner.dart';
import 'mode_selection_card.dart';
import 'social_trust_preview_card.dart';

class CreateModeBody extends StatelessWidget {
  const CreateModeBody({super.key});

  CreateModeController get controller {
    CreateModeController.ensureController();
    return Get.find<CreateModeController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: const Color(0xFFF8F9FB),
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
          child: Row(
            children: [
              IconButton(
                onPressed: controller.goBack,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                  color: Color(0xFF111827),
                ),
              ),
              const Expanded(
                child: Text(
                  'Choose Mode',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            final selected = controller.selectedMode.value;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...controller.options.map(
                    (option) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: ModeSelectionCard(
                        option: option,
                        isSelected: selected == option.type,
                        onTap: () => controller.selectMode(option.type),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  AiMatchmakingBanner(
                    nearbyRiders: controller.nearbyRiders.value,
                    routeSharePercent: controller.routeSharePercent.value,
                    earnCoupons: controller.earnCoupons.value,
                    onOfferSeats: controller.offerSeatsNow,
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: controller.selectReward,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button,
                        foregroundColor: const Color(0xFF111827),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Select Reward',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  SocialTrustPreviewCard(
                    trustScore: controller.trustScore.value,
                    avatarUrls: controller.mutualAvatarUrls,
                    extraCount: controller.mutualCirclesExtra.value,
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
