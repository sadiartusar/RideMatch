import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class OnboardingRewardsArt extends StatelessWidget {
  const OnboardingRewardsArt({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 310,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(36),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ambient soft green glow behind the cards
          Positioned(
            top: 24,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.splashBackground.withValues(alpha: 0.3),
              ),
            ),
          ),

          // Main bright neon lime green card
          Positioned(
            top: 60,
            left: 36,
            right: 48,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
              decoration: BoxDecoration(
                color: AppColors.splashBackground,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.splashBackground.withValues(alpha: 0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Gain instead of earn',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF14532D),
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'ECO-MISSION REWARD',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                      color: Color(0xFF166534),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Top-right floating badge: 12.5kg CO2 saved
          Positioned(
            top: 28,
            right: 42,
            child: Container(
              width: 80,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFBBF24),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFBBF24).withValues(alpha: 0.45),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.eco_rounded,
                    size: 24,
                    color: Colors.black,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '12.5kg',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    'CO2 SAVED',
                    style: TextStyle(
                      fontSize: 7.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF78350F),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom-left floating card: Weekly Impact
          Positioned(
            bottom: 40,
            left: 28,
            right: 80,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4B5563),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.local_florist_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Weekly Impact',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF111827),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '3/5 rides completed',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: const SizedBox(
                      height: 6,
                      child: LinearProgressIndicator(
                        value: 0.6,
                        backgroundColor: Color(0xFFE5E7EB),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFF14532D),
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
