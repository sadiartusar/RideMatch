import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_match/features/flex_wallet/controller/flex_wallet_controller.dart';


class ActiveMissionsCard extends GetView<FlexWalletController> {
  const ActiveMissionsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'ACTIVE MISSIONS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
              color: Color(0xFF6B7280),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
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
          child: Stack(
            children: [
              // Left green indicator strip
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 4,
                  color: const Color(0xFF00E63D),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Text(
                                    controller.missionTitle.value,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E2022),
                                    ),
                                  )),
                              const SizedBox(height: 2),
                              Obx(() => Text(
                                    controller.missionSubtitle.value,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF9E9E9E),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        // Medal badge circle
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE5E7EB),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.military_tech,
                            color: Color(0xFF4B5563),
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Multi-segment progress indicator
                    Obx(() {
                      final completed = controller.completedRides.value;
                      final total = controller.totalRides.value;
                      return Row(
                        children: List.generate(total, (index) {
                          final isDone = index < completed;
                          return Expanded(
                            child: Container(
                              height: 4,
                              margin: EdgeInsets.only(right: index == total - 1 ? 0 : 4),
                              decoration: BoxDecoration(
                                color: isDone ? const Color(0xFF00E63D) : const Color(0xFFE5E7EB),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          );
                        }),
                      );
                    }),
                    const SizedBox(height: 8),

                    // Rides count label
                    Align(
                      alignment: Alignment.centerRight,
                      child: Obx(() => Text(
                            '${controller.completedRides.value}/${controller.totalRides.value} Rides Done',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00C836),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}