import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/ride_verified_controller.dart';
import '../models/ride_verification_model.dart';
import 'verified_reward_card.dart';

/// Embedded Ride Verified body for the Driver Home Shell.
class RideVerifiedBody extends StatelessWidget {
  const RideVerifiedBody({
    super.key,
    required this.rideData,
    required this.onBack,
  });

  final RideVerificationModel rideData;
  final VoidCallback onBack;

  RideVerifiedController get _controller {
    if (Get.isRegistered<RideVerifiedController>()) {
      final ctrl = Get.find<RideVerifiedController>();
      ctrl.updateRideData(rideData);
      return ctrl;
    }
    final ctrl = Get.put(RideVerifiedController());
    ctrl.updateRideData(rideData);
    return ctrl;
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final isDark = rideData.isDark;
    final textColor = isDark ? Colors.white : const Color(0xFF111827);
    final borderCol =
        isDark ? const Color(0xFF262B32) : const Color(0xFFE5E7EB);
    const greenAccent = Color(0xFF32E116);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        onBack();
      },
      child: Column(
        children: [
          // Top App Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: textColor,
                    size: 22,
                  ),
                  onPressed: onBack,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Verified Ride',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 48), // Balance leading back button
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 1. Big Checkmark Circle
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: greenAccent.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: greenAccent.withValues(alpha: 0.4),
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: greenAccent,
                        size: 46,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 2. Journey Complete Pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: greenAccent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: greenAccent.withValues(alpha: 0.35),
                      ),
                    ),
                    child: const Text(
                      'JOURNEY COMPLETE',
                      style: TextStyle(
                        color: greenAccent,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 3. Title & Subtitle
                  Text(
                    'Ride Verified',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'The transaction is finalized. Both parties have successfully confirmed the exchange.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark
                            ? const Color(0xFF9CA3AF)
                            : const Color(0xFF6B7280),
                        fontSize: 12.5,
                        height: 1.35,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 4. Rewards Cards
                  VerifiedRewardCard(
                    couponsTransferred: rideData.couponsTransferred,
                    gasVoucherAmount: rideData.gasVoucherAmount,
                    isDark: isDark,
                  ),

                  // const SizedBox(height: 16),

                  // // See Impact & Rate Trip options
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: OutlinedButton(
                  //         onPressed: controller.seeImpact,
                  //         style: OutlinedButton.styleFrom(
                  //           foregroundColor: textColor,
                  //           backgroundColor: isDark
                  //               ? const Color(0xFF14171A)
                  //               : Colors.white,
                  //           side: BorderSide(color: borderCol, width: 1.2),
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(14),
                  //           ),
                  //         ),
                  //         child: const Text(
                  //           'See Impact',
                  //           style: TextStyle(
                  //             fontSize: 13.5,
                  //             fontWeight: FontWeight.w800,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 10),
                  //     Expanded(
                  //       child: OutlinedButton(
                  //         onPressed: controller.rateTrip,
                  //         style: OutlinedButton.styleFrom(
                  //           foregroundColor: textColor,
                  //           backgroundColor: isDark
                  //               ? const Color(0xFF14171A)
                  //               : Colors.white,
                  //           side: BorderSide(color: borderCol, width: 1.2),
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(14),
                  //           ),
                  //         ),
                  //         child: const Text(
                  //           'Rate Trip',
                  //           style: TextStyle(
                  //             fontSize: 13.5,
                  //             fontWeight: FontWeight.w800,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  const Spacer(),

                  // 5. BACK LIVE ROUTE Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: controller.backLiveRoute,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: textColor,
                        backgroundColor:
                            isDark ? const Color(0xFF14171A) : Colors.white,
                        side: BorderSide(color: borderCol, width: 1.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'BACK LIVE ROUTE',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 6. View Wallet Primary CTA Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: controller.viewWallet,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button,
                        foregroundColor: AppColors.buttonForeground,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'View Wallet',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
