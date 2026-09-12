import 'package:flutter/material.dart';

import '../models/rider_match_model.dart';

class DriverChatTripCard extends StatelessWidget {
  const DriverChatTripCard({
    super.key,
    required this.match,
  });

  final RiderMatchModel match;

  @override
  Widget build(BuildContext context) {
    const cardBg = Color(0xFF16191D);
    const borderCol = Color(0xFF252A32);
    const greenAccent = Color(0xFF32E116);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderCol),
      ),
      child: Column(
        children: [
          // Rider info header row
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: match.avatarUrl != null && match.avatarUrl!.isNotEmpty
                    ? Image.network(
                        match.avatarUrl!,
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Image.asset(
                          match.avatarAsset,
                          width: 44,
                          height: 44,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        match.avatarAsset,
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            match.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.check_circle_rounded,
                          color: greenAccent,
                          size: 16,
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    const Row(
                      children: [
                        Text(
                          '4.9 ★',
                          style: TextStyle(
                            color: Color(0xFFFBBF24),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          '•',
                          style: TextStyle(color: Color(0xFF6B7280)),
                        ),
                        SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            'TESLA MODEL 3',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Online pill
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: greenAccent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: greenAccent.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: greenAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Online',
                      style: TextStyle(
                        color: greenAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Route row: San Francisco (Pickup) -> Chinatown (Drop-off)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF101215),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'San Francisco...',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'PICKUP',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                // Arrow
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 24,
                        height: 1.5,
                        color: const Color(0xFF4B5563),
                      ),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Color(0xFF9CA3AF),
                        size: 14,
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Chinatown',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'DROP-OFF',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // 4 stats box row: ETA to you | Distance | Est. Coupon | Gas Voucher
          Row(
            children: [
              _buildStatBox(
                label: 'ETA to you',
                value: '5 min',
                greenAccent: greenAccent,
              ),
              const SizedBox(width: 6),
              _buildStatBox(
                label: 'Distance',
                value: '1.8 km',
                greenAccent: greenAccent,
              ),
              const SizedBox(width: 6),
              _buildStatBox(
                label: 'Est. Coupon',
                value: '1',
                greenAccent: greenAccent,
              ),
              const SizedBox(width: 6),
              _buildStatBox(
                label: 'Gas Voucher',
                value: '\$${match.netEarnings.toStringAsFixed(2)}',
                greenAccent: greenAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox({
    required String label,
    required String value,
    required Color greenAccent,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF101215),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 9.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: TextStyle(
                color: greenAccent,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
