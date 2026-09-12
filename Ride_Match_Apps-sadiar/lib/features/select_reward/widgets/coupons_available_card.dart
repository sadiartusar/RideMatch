import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class CouponsAvailableCard extends StatelessWidget {
  const CouponsAvailableCard({
    super.key,
    required this.coupons,
  });

  final int coupons;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8E8E4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            top: -40,
            right: -30,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.button.withValues(alpha: 0.35),
                    AppColors.button.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Text(
                '$coupons',
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  height: 1,
                  letterSpacing: -1.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'COUPONS AVAILABLE',
                style: TextStyle(
                  color: AppColors.button,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 16,
                      color: Color(0xFF9CA3AF),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Offer any number of coupons — no minimum.',
                        style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
