import 'package:flutter/material.dart';

import 'profile_theme_colors.dart';

class ProfileMenuList extends StatelessWidget {
  const ProfileMenuList({
    super.key,
    required this.activeMissions,
    required this.sharedRides,
    required this.onRideIdentity,
    required this.onMissions,
    required this.onRideHistory,
    required this.onSettings,
    this.isDark = false,
  });

  final int activeMissions;
  final int sharedRides;
  final VoidCallback onRideIdentity;
  final VoidCallback onMissions;
  final VoidCallback onRideHistory;
  final VoidCallback onSettings;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MenuCard(
          icon: Icons.shield_outlined,
          title: 'Ride Identity',
          subtitle: 'Edit your preferences',
          onTap: onRideIdentity,
          isDark: isDark,
        ),
        const SizedBox(height: 10),
        _MenuCard(
          icon: Icons.workspace_premium_outlined,
          title: 'My Missions',
          subtitle: '$activeMissions active missions',
          onTap: onMissions,
          isDark: isDark,
        ),
        const SizedBox(height: 10),
        _MenuCard(
          icon: Icons.hub_outlined,
          title: 'Ride History',
          subtitle: '$sharedRides shared rides',
          onTap: onRideHistory,
          isDark: isDark,
        ),
        const SizedBox(height: 10),
        _MenuCard(
          icon: Icons.settings_outlined,
          title: 'Settings',
          subtitle: 'Account & notifications',
          onTap: onSettings,
          isDark: isDark,
        ),
      ],
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.isDark,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colors = ProfileThemeColors(isDark: isDark);

    return Material(
      color: colors.card,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: colors.iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 20, color: colors.icon),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: colors.title,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: colors.label,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colors.label,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
