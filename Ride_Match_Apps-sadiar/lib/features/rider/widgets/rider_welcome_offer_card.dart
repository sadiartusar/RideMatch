import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class RiderWelcomeOfferCard extends StatelessWidget {
  const RiderWelcomeOfferCard({
    super.key,
    this.couponCount = 500,
    required this.onOpenWallet,
  });

  final int couponCount;
  final VoidCallback onOpenWallet;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF167B27),
            Color(0xFF0F581B),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF167B27).withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tag: WELCOME OFFER
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.confirmation_number_rounded,
                color: Color(0xFF4ADE80),
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                'WELCOME OFFER',
                style: TextStyle(
                  color: Color(0xFF4ADE80),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Heading
          Text(
            "You've got $couponCount starter\ncoupons",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.22,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 10),
          // Subtitle
          const Text(
            'Your wallet is ready for ride offers and exclusive missions.',
            style: TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 13.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          // Open Wallet Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onOpenWallet,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button,
                foregroundColor: AppColors.buttonForeground,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Open Wallet',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
