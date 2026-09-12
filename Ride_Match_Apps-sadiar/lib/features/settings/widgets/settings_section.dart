import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class SettingsSectionCard extends StatelessWidget {
  const SettingsSectionCard({
    super.key,
    required this.title,
    required this.children,
    this.isDark = false,
  });

  final String title;
  final List<Widget> children;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF16181B) : Colors.white;
    final border = isDark ? AppColors.darkBorder : AppColors.border;
    final titleColor =
        isDark ? const Color(0xFF9CA3AF) : const Color(0xFF9CA3AF);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: border),
          ),
          child: Column(
            children: [
              for (var i = 0; i < children.length; i++) ...[
                children[i],
                if (i != children.length - 1)
                  Divider(
                    height: 1,
                    thickness: 1,
                    indent: 52,
                    color: border,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class SettingsToggleTile extends StatelessWidget {
  const SettingsToggleTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
    this.isDark = false,
  });

  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final titleColor = isDark ? Colors.white : const Color(0xFF111827);
    final iconColor =
        isDark ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 22, color: iconColor),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: titleColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.button,
          ),
        ],
      ),
    );
  }
}

class SettingsNavTile extends StatelessWidget {
  const SettingsNavTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.value,
    this.isDark = false,
  });

  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final titleColor = isDark ? Colors.white : const Color(0xFF111827);
    final iconColor =
        isDark ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563);
    final valueColor =
        isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 22, color: iconColor),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (value != null) ...[
              Text(
                value!,
                style: TextStyle(
                  color: valueColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
            ],
            Icon(
              Icons.chevron_right_rounded,
              color: valueColor,
            ),
          ],
        ),
      ),
    );
  }
}
