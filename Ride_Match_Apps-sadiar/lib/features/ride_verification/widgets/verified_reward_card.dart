import 'package:flutter/material.dart';

class VerifiedRewardCard extends StatelessWidget {
  const VerifiedRewardCard({
    super.key,
    required this.couponsTransferred,
    required this.gasVoucherAmount,
    this.isDark = true,
  });

  final int couponsTransferred;
  final double gasVoucherAmount;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : const Color(0xFF111827);
    final cardBg = isDark ? const Color(0xFF16191D) : Colors.white;
    final borderCol = isDark ? const Color(0xFF262B32) : const Color(0xFFE5E7EB);

    return Column(
      children: [
        // 1. Coupons Transferred Card
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderCol),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF101215) : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563),
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coupons transferred',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Escrow to Receiving Wallet',
                      style: TextStyle(
                        color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '$couponsTransferred',
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // 2. Electric / Gas Voucher Card
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderCol),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF101215) : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.bolt_rounded,
                  color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Electric / Gas Voucher',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Escrow to Receiving Wallet',
                      style: TextStyle(
                        color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '\$${gasVoucherAmount.toStringAsFixed(0)}',
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
