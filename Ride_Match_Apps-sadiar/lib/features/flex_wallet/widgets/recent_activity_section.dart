import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_match/features/flex_wallet/controller/flex_wallet_controller.dart';


class RecentActivitySection extends GetView<FlexWalletController> {
  const RecentActivitySection({Key? key}) : super(key: key);

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
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'RECENT ACTIVITY',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                  color: Color(0xFF6B7280),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.snackbar('All Activity', 'Showing full history');
                },
                child: const Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00C836),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Items list
          Obx(
            () => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.recentActivities.length,
              separatorBuilder: (context, index) => const Divider(height: 20, color: Color(0xFFF3F4F6)),
              itemBuilder: (context, index) {
                final item = controller.recentActivities[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E2022),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.date,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      item.amount,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: item.isPositive ? const Color(0xFF00C836) : const Color(0xFFEF4444),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}