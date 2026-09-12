import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class DriverWalletCard extends StatelessWidget {
  const DriverWalletCard({
    super.key,
    required this.balance,
    required this.onOpenWallet,
  });

  final String balance;
  final VoidCallback onOpenWallet;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF262B32),
          width: 1,
        ),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF171A1D),
            Color(0xFF132918),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Receiving Wallet',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Color(0xFF111827),
                  size: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            balance,
            style: const TextStyle(
              color: Color(0xFF32E116),
              fontSize: 48,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Ride Settlements And Completed Trip\nEarnings',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 20),
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
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
