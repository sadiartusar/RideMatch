import 'package:flutter/material.dart';

class DriverRouteSummaryCard extends StatelessWidget {
  const DriverRouteSummaryCard({
    super.key,
    required this.ridersCount,
    required this.sharePercentage,
    required this.detour,
    required this.rewards,
    required this.co2Save,
  });

  final int ridersCount;
  final int sharePercentage;
  final String detour;
  final String rewards;
  final String co2Save;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF171A1D),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF262B32),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$ridersCount riders ',
                  style: const TextStyle(
                    color: Color(0xFF32E116),
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: 'share $sharePercentage% of your route',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              // Detour
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'DETOUR',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      detour,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 28,
                color: const Color(0xFF262B32),
              ),
              // Rewards
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'REWARDS',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      rewards,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 28,
                color: const Color(0xFF262B32),
              ),
              // CO2 Save
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'CO2 SAVE',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      co2Save,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
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
