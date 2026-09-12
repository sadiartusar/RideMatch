import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/user_profile_model.dart';
import 'user_profile_section_label.dart';

class UserProfileExperience extends StatelessWidget {
  const UserProfileExperience({
    super.key,
    required this.profile,
  });

  final UserProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UserProfileSectionLabel('EXPERIENCE & PERFORMANCE'),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
          decoration: BoxDecoration(
            color: const Color(0xFFF6FAF5),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFFE6EDE4)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE5F3E4),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const SizedBox(
                      width: 22,
                      height: 22,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.circle_outlined,
                            color: Color(0xFF16A34A),
                            size: 22,
                          ),
                          Icon(
                            Icons.radio_button_unchecked,
                            color: Color(0xFF16A34A),
                            size: 10,
                          ),
                          ColoredBox(
                            color: Color(0xFF16A34A),
                            child: SizedBox(width: 10, height: 1.6),
                          ),
                          ColoredBox(
                            color: Color(0xFF16A34A),
                            child: SizedBox(width: 1.6, height: 8),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${profile.experienceYears} years driving',
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _Metric(
                      value: '${profile.acceptanceRate}%',
                      label: 'Acceptance Rate',
                    ),
                  ),
                  Expanded(
                    child: _Metric(
                      value: '${profile.onTimeRate}%',
                      label: 'On-time Arrival',
                    ),
                  ),
                  Expanded(
                    child: _Metric(
                      value: '${profile.cancellationRate}%',
                      label: 'Cancellations',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            const Text(
              'Languages:',
              style: TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Wrap(
                spacing: 10,
                runSpacing: 4,
                children: profile.languages
                    .map(
                      (language) => Text(
                        language,
                        style: const TextStyle(
                          color: AppColors.success,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF16A34A),
            fontSize: 22,
            fontWeight: FontWeight.w800,
            height: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 11,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
