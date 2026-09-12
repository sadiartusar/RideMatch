import 'package:flutter/material.dart';

import '../models/wallet_model.dart';

class DriverReceivingWalletCard extends StatelessWidget {
  const DriverReceivingWalletCard({
    super.key,
    required this.wallet,
  });

  final DriverWalletModel wallet;

  @override
  Widget build(BuildContext context) {
    const greenAccent = Color(0xFF32E116);
    const borderCol = Color(0xFF262B32);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: borderCol),
        gradient: const RadialGradient(
          center: Alignment(0.8, -0.6),
          radius: 1.2,
          colors: [
            Color(0xFF123419),
            Color(0xFF16181B),
            Color(0xFF131518),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Receiving Wallet + Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Receiving Wallet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.2,
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFFE5E7EB),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Color(0xFF111827),
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Big 1250 Balance
          Text(
            '${wallet.totalCoupons}',
            style: const TextStyle(
              color: greenAccent,
              fontSize: 38,
              fontWeight: FontWeight.w900,
              height: 1.0,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Ride Settlements And Completed Trip Earnings',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),

          // 2 Status Columns with vertical divider
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF101215),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: borderCol),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'AVAILABLE COUPON',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${wallet.availableCoupons}',
                        style: const TextStyle(
                          color: greenAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 32,
                  color: borderCol,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PENDING COUPON',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${wallet.pendingCoupons}',
                        style: const TextStyle(
                          color: Color(0xFFFBBF24),
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Electric / Gas Incentive Balance Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF131714),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFF1E3A24),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.local_gas_station_rounded,
                      color: Color(0xFFFBBF24),
                      size: 15,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Electric / Gas Incentive Balance',
                      style: TextStyle(
                        color: Color(0xFFFBBF24),
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${wallet.gasIncentiveBalance.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Net earnings after fee',
                  style: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
