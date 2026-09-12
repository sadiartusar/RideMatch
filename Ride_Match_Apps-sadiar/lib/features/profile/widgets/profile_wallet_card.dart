import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'profile_theme_colors.dart';

class ProfileWalletCard extends StatelessWidget {
  const ProfileWalletCard({
    super.key,
    required this.totalCoupons,
    required this.travelCoupons,
    required this.earnedCoupons,
    required this.expiringCoupons,
    required this.onOpenWallet,
    this.isDark = false,
  });

  final int totalCoupons;
  final int travelCoupons;
  final int earnedCoupons;
  final int expiringCoupons;
  final VoidCallback onOpenWallet;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colors = ProfileThemeColors(isDark: isDark);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.cardMuted,
            colors.walletGlow,
            colors.cardMuted,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Your Wallet',
                  style: TextStyle(
                    color: colors.title,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: AppColors.button,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Color(0xFF0F172A),
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$totalCoupons',
                style: TextStyle(
                  color: isDark ? AppColors.button : const Color(0xFF15803D),
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  height: 1,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'COUPONS',
                  style: TextStyle(
                    color: colors.title,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _WalletLine(
            title: 'Travel',
            subtitle: 'Available for ride booking',
            value: travelCoupons,
            isDark: isDark,
          ),
          const SizedBox(height: 8),
          _WalletLine(
            title: 'Earned',
            subtitle: 'Rewards from rides. Exchangeable in marketplace',
            value: earnedCoupons,
            isDark: isDark,
          ),
          const SizedBox(height: 8),
          _WalletLine(
            title: 'Expiring Soon',
            value: expiringCoupons,
            accentBar: true,
            isDark: isDark,
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onOpenWallet,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.secondaryButton,
                foregroundColor: colors.title,
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WalletLine extends StatelessWidget {
  const _WalletLine({
    required this.title,
    required this.value,
    required this.isDark,
    this.subtitle,
    this.accentBar = false,
  });

  final String title;
  final String? subtitle;
  final int value;
  final bool accentBar;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colors = ProfileThemeColors(isDark: isDark);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          if (accentBar) ...[
            Container(
              width: 4,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xFFFBBF24),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colors.title,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: colors.label,
                      fontSize: 12,
                      height: 1.3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '$value',
            style: TextStyle(
              color: colors.title,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
