import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_match/features/flex_wallet/controller/flex_wallet_controller.dart';


class EarnedWalletCard extends GetView<FlexWalletController> {
  const EarnedWalletCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Circular progress badge
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Obx(() => CircularProgressIndicator(
                          value: controller.earnedPercentage.value / 100.0,
                          strokeWidth: 4,
                          backgroundColor: const Color(0xFFE5E7EB),
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00E63D)),
                        )),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() => Text(
                            '${controller.earnedPercentage.value}%',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E2022),
                            ),
                          )),
                      const Text(
                        'MINIMUM',
                        style: TextStyle(
                          fontSize: 6.5,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF9E9E9E),
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 14),

              // Title and Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Earned Wallet',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E2022),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Rewards from missions',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                  ],
                ),
              ),

              // Credits
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(() => Text(
                        '${controller.earnedCredits.value}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1E2022),
                        ),
                      )),
                  const Text(
                    'CREDITS',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD97706),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Redeem Benefits Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.onRedeemBenefits,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF3F4F6),
                foregroundColor: const Color(0xFF374151),
                padding: const EdgeInsets.symmetric(vertical: 13),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'REDEEM BENEFITS',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}