import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_match/features/driver/controllers/driver_set_route_controller.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../models/rider_match_model.dart';
import 'driver_ai_rationale_grid.dart';

/// Embedded Match Confirm body for the Driver Home Shell.
class DriverMatchConfirmBody extends StatelessWidget {
  const DriverMatchConfirmBody({
    super.key,
    required this.match,
    required this.onBack,
    required this.onChatNow,
    required this.onLiveRoute,
    this.onViewProfile,
  });

  final RiderMatchModel match;
  final VoidCallback onBack;
  final VoidCallback onChatNow;
  final VoidCallback onLiveRoute;
  final VoidCallback? onViewProfile;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        onBack();
      },
      child: Column(
        children: [
          // Top Header Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: onBack,
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Match Confirm',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 48), // Balance leading back button
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Car Image with "Great Match!" badge
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          AppAssets.profileVehicle,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              color: const Color(0xFF1E2227),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.directions_car_rounded,
                                size: 60,
                                color: Colors.white24,
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 14,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF32E116),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.35),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.black,
                                size: 16,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Great Match!',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // Request Accepted Status box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF16191D),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF262B32),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF32E116),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'REQUEST ACCEPTED',
                              style: TextStyle(
                                color: Color(0xFF32E116),
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Review completed and rider selected.',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 2x2 AI Matching Rationale cards
                  const DriverAiRationaleGrid(),
                  const SizedBox(height: 24),
                  // Primary CTA: "Chat Now"
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: onChatNow,
                      icon: const Icon(
                        Icons.chat_bubble_rounded,
                        color: Colors.black,
                        size: 18,
                      ),
                      label: const Text(
                        'Chat Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button,
                        foregroundColor: AppColors.buttonForeground,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Secondary Button: "LIVE ROUTE"
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: onLiveRoute,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFF16191D),
                        foregroundColor: Colors.white,
                        side: const BorderSide(
                          color: Color(0xFF262B32),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'LIVE ROUTE',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // "View Profile" Text button
                  Center(
                    child: TextButton(
                      onPressed: () {
                        if (onViewProfile != null) {
                          onViewProfile!();
                        } else if (Get.isRegistered<DriverSetRouteController>()) {
                          Get.find<DriverSetRouteController>().openProfile(match);
                        } else {
                          Get.toNamed(AppRoutes.profile);
                        }
                      },
                      child: const Text(
                        'View Profile',
                        style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
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
