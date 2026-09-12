import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'profile_theme_colors.dart';

class ProfileRidePreferences extends StatelessWidget {
  const ProfileRidePreferences({
    super.key,
    required this.genderPreference,
    required this.ageRange,
    required this.carType,
    required this.verifiedOnly,
    required this.onVerifiedOnlyChanged,
    this.isDark = false,
  });

  final String genderPreference;
  final String ageRange;
  final String carType;
  final bool verifiedOnly;
  final ValueChanged<bool> onVerifiedOnlyChanged;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colors = ProfileThemeColors(isDark: isDark);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RIDE PREFERENCES',
            style: TextStyle(
              color: colors.label,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: 8),
          _PreferenceRow(
            label: 'Gender Preference',
            value: genderPreference,
            isDark: isDark,
          ),
          _PreferenceRow(
            label: 'Age Range',
            value: ageRange,
            isDark: isDark,
          ),
          _PreferenceRow(
            label: 'Car Type',
            value: carType,
            isDark: isDark,
            valueColor: isDark ? AppColors.button : const Color(0xFF15803D),
            valueWeight: FontWeight.w700,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Verified Only',
                    style: TextStyle(
                      color: colors.title,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Switch.adaptive(
                  value: verifiedOnly,
                  activeThumbColor: Colors.white,
                  activeTrackColor: AppColors.button,
                  onChanged: onVerifiedOnlyChanged,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PreferenceRow extends StatelessWidget {
  const _PreferenceRow({
    required this.label,
    required this.value,
    required this.isDark,
    this.valueColor,
    this.valueWeight = FontWeight.w500,
  });

  final String label;
  final String value;
  final bool isDark;
  final Color? valueColor;
  final FontWeight valueWeight;

  @override
  Widget build(BuildContext context) {
    final colors = ProfileThemeColors(isDark: isDark);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: colors.title,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? colors.body,
              fontSize: 14,
              fontWeight: valueWeight,
            ),
          ),
        ],
      ),
    );
  }
}
