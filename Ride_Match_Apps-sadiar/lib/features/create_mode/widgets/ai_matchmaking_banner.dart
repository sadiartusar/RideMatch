import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class AiMatchmakingBanner extends StatelessWidget {
  const AiMatchmakingBanner({
    super.key,
    required this.nearbyRiders,
    required this.routeSharePercent,
    required this.earnCoupons,
    required this.onOfferSeats,
  });

  final int nearbyRiders;
  final int routeSharePercent;
  final int earnCoupons;
  final VoidCallback onOfferSeats;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDCFCE7)),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 4,
            top: 8,
            child: Icon(
              Icons.auto_awesome,
              size: 48,
              color: AppColors.button.withValues(alpha: 0.18),
            ),
          ),
          Positioned(
            right: 36,
            bottom: 52,
            child: Icon(
              Icons.star_rounded,
              size: 18,
              color: AppColors.button.withValues(alpha: 0.22),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.auto_awesome,
                    size: 14,
                    color: Color(0xFF6B7280),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'AI MATCHMAKING',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '$nearbyRiders nearby riders share $routeSharePercent% of your route.',
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  height: 1.3,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Tap to offer seats and earn $earnCoupons coupons.',
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: onOfferSeats,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF111827),
                    foregroundColor: AppColors.button,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Offer seats now',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.button,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
