import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/select_reward_controller.dart';
import 'available_rewards_section.dart';
import 'coupons_available_card.dart';
import 'voucher_amount_grid.dart';

class SelectRewardBody extends GetView<SelectRewardController> {
  const SelectRewardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF8F9FB),
      child: Column(
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
                    'Select Reward',
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
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CouponsAvailableCard(
                      coupons: controller.couponsAvailable.value,
                    ),
                    const SizedBox(height: 22),
                    VoucherAmountGrid(
                      vouchers: controller.vouchers,
                      selectedDollars: controller.selectedVoucherDollars.value,
                      onSelect: controller.selectVoucher,
                    ),
                    const SizedBox(height: 24),
                    AvailableRewardsSection(
                      rewards: controller.merchantRewards,
                      specialOffer: controller.specialOffer,
                      selectedId: controller.selectedRewardId.value,
                      onSelect: controller.selectReward,
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: controller.offerThisReward,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.button,
                          foregroundColor: const Color(0xFF111827),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Offer This Reward',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF111827),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
