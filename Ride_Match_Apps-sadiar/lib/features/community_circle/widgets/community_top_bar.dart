import 'package:flutter/material.dart';

class CommunityTopBar extends StatelessWidget {
  const CommunityTopBar({
    super.key,
    required this.title,
    required this.onBack,
    required this.onNotificationTap,
    required this.onMenuTap,
    this.isDark = false,
  });

  final String title;
  final VoidCallback onBack;
  final VoidCallback onNotificationTap;
  final VoidCallback onMenuTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final titleColor = isDark ? Colors.white : const Color(0xFF111827);
    final actionBg =
        isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6);
    final actionBorder =
        isDark ? const Color(0xFF2C333A) : const Color(0xFFE5E7EB);

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
              color: titleColor,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
        ),
        _CircleAction(
          background: actionBg,
          border: actionBorder,
          onTap: onNotificationTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.notifications_none_rounded,
                color: titleColor,
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
          background: actionBg,
          border: actionBorder,
          onTap: onMenuTap,
          child: Icon(
            Icons.menu_rounded,
            color: titleColor,
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
    required this.background,
    required this.border,
  });

  final Widget child;
  final VoidCallback onTap;
  final Color background;
  final Color border;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
          border: Border.all(color: border),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
