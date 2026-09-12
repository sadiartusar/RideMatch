import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'profile_theme_colors.dart';

class ProfileStatsGrid extends StatelessWidget {
  const ProfileStatsGrid({
    super.key,
    required this.trustScore,
    required this.rides,
    required this.kmShared,
    required this.isIdVerified,
    this.isDark = false,
  });

  final double trustScore;
  final int rides;
  final int kmShared;
  final bool isIdVerified;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colors = ProfileThemeColors(isDark: isDark);
    final valueStyle = TextStyle(
      color: colors.title,
      fontSize: 28,
      fontWeight: FontWeight.w900,
      letterSpacing: -0.6,
    );

    return Column(
      children: [
        Divider(height: 1, color: colors.border),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: _StatCell(
                label: 'TRUST SCORE',
                labelColor: colors.label,
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: AppColors.button,
                      size: 22,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      trustScore.toStringAsFixed(1),
                      style: valueStyle,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _StatCell(
                label: 'RIDES',
                labelColor: colors.label,
                child: Text('$rides', style: valueStyle),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: _StatCell(
                label: 'VERIFIED ID',
                labelColor: colors.label,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: AppColors.button,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 18,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
            ),
            Expanded(
              child: _StatCell(
                label: 'KM SHARED',
                labelColor: colors.label,
                child: Text('$kmShared', style: valueStyle),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.child,
    required this.label,
    required this.labelColor,
  });

  final Widget child;
  final String label;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.7,
          ),
        ),
      ],
    );
  }
}
