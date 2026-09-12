import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../models/rider_match_model.dart';

class DriverPreMatchSummaryCard extends StatelessWidget {
  const DriverPreMatchSummaryCard({
    super.key,
    required this.match,
    this.carModel = 'TESLA MODEL 3',
    this.pickup = 'San Francisco...',
    this.dropOff = 'Chinatown',
    this.eta = '5 min',
    this.distance = '1.8 km',
    this.coupons = '1',
    this.voucher = '\$9.60',
  });

  final RiderMatchModel match;
  final String carModel;
  final String pickup;
  final String dropOff;
  final String eta;
  final String distance;
  final String coupons;
  final String voucher;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF16191D),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF262B32),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Rider Header Row
          Row(
            children: [
              // Avatar with Online dot
              Stack(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage(match.avatarAsset.isNotEmpty
                        ? match.avatarAsset
                        : AppAssets.profileHero),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFF32E116),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF16191D),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              // Name, Rating & Car
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          match.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.verified,
                          color: Color(0xFF32E116),
                          size: 16,
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '4.9 ★ • $carModel',
                      style: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              // Online status pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF16381D),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF1F5128),
                    width: 0.8,
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '• Online',
                      style: TextStyle(
                        color: Color(0xFF32E116),
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Route points with arrow line
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF111417),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pickup,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'PICKUP',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Color(0xFF4B5563),
                      size: 18,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      dropOff,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'DROP-OFF',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          // 4 Stats in a row
          Row(
            children: [
              Expanded(
                child: _buildStatItem('ETA to you', eta, isGreen: true),
              ),
              Expanded(
                child: _buildStatItem('Distance', distance, isGreen: true),
              ),
              Expanded(
                child: _buildStatItem('Dr. Coupon', coupons, isGreen: false),
              ),
              Expanded(
                child: _buildStatItem('Gas Voucher', voucher, isGreen: true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, {required bool isGreen}) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: isGreen ? const Color(0xFF32E116) : Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
