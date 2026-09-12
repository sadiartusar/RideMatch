import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/user_profile_model.dart';

class UserProfileRecommendation extends StatelessWidget {
  const UserProfileRecommendation({
    super.key,
    required this.profile,
  });

  final UserProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome,
                color: AppColors.button,
                size: 16,
              ),
              const SizedBox(width: 6),
              const Expanded(
                child: Text(
                  'SMART RECOMMENDATION',
                  style: TextStyle(
                    color: AppColors.button,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              Icon(
                Icons.bolt_rounded,
                color: AppColors.button.withValues(alpha: 0.95),
                size: 28,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${profile.matchPercentage}% Match for your route',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final chip in profile.recommendationChips)
                _RecChip(label: chip),
              _RecChip(
                label: profile.evHighlightChip,
                highlighted: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecChip extends StatelessWidget {
  const _RecChip({
    required this.label,
    this.highlighted = false,
  });

  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: highlighted ? const Color(0xFF22C55E) : const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(20),
        border: highlighted
            ? null
            : Border.all(color: const Color(0xFF374151)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: highlighted ? const Color(0xFF052E16) : const Color(0xFFE5E7EB),
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
