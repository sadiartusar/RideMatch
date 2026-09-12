import 'package:flutter/material.dart';

import 'profile_theme_colors.dart';

class ProfileTopBar extends StatelessWidget {
  const ProfileTopBar({
    super.key,
    required this.onBack,
    required this.onNotificationTap,
    required this.onMenuTap,
    this.isDark = false,
  });

  final VoidCallback onBack;
  final VoidCallback onNotificationTap;
  final VoidCallback onMenuTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colors = ProfileThemeColors(isDark: isDark);

    return Row(
      children: [
        InkWell(
          onTap: onBack,
          borderRadius: BorderRadius.circular(22),
          child: SizedBox(
            width: 40,
            height: 40,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: colors.title,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            'Profile',
            style: TextStyle(
              color: colors.title,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),
        ),
        _CircleAction(
          isDark: isDark,
          onTap: onNotificationTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.notifications_none_rounded,
                color: colors.title,
                size: 22,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        _CircleAction(
          isDark: isDark,
          onTap: onMenuTap,
          child: Icon(
            Icons.menu_rounded,
            color: colors.title,
            size: 22,
          ),
        ),
      ],
    );
  }
}

class _CircleAction extends StatelessWidget {
  const _CircleAction({
    required this.child,
    required this.onTap,
    required this.isDark,
  });

  final Widget child;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colors = ProfileThemeColors(isDark: isDark);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: colors.cardMuted,
          shape: BoxShape.circle,
          border: Border.all(color: colors.border),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
