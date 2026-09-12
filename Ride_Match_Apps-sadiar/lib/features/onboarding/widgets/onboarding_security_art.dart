import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class OnboardingSecurityArt extends StatelessWidget {
  const OnboardingSecurityArt({super.key});

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
          // Ambient soft green glow behind the badge
          Positioned(
            left: 30,
            top: 20,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.splashBackground.withValues(alpha: 0.25),
              ),
            ),
          ),

          // Main dark green rounded square
          Container(
            width: 190,
            height: 190,
            decoration: BoxDecoration(
              color: const Color(0xFF14532D),
              borderRadius: BorderRadius.circular(44),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF14532D).withValues(alpha: 0.25),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Shield icon in bright lime green
                  Icon(
                    Icons.shield_rounded,
                    size: 88,
                    color: AppColors.splashBackground,
                  ),
                  // Dark green checkmark inside shield
                  Positioned(
                    top: 24,
                    child: Icon(
                      Icons.check_rounded,
                      size: 38,
                      color: Color(0xFF14532D),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Top-left floating badge (verified checkmark circle)
          Positioned(
            top: 44,
            left: 48,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.splashBackground,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.splashBackground.withValues(alpha: 0.4),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.check_circle_outline_rounded,
                  color: Color(0xFF14532D),
                  size: 26,
                ),
              ),
            ),
          ),

          // Bottom-right floating badge (SOS ACTIVE)
          Positioned(
            bottom: 48,
            right: 44,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.4),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.crisis_alert_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'SOS ACTIVE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.6,
                      color: Colors.white,
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
