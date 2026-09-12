import 'package:flutter/material.dart';

class NotificationsTopBar extends StatelessWidget {
  const NotificationsTopBar({
    super.key,
    required this.onBack,
    this.isDark = false,
  });

  final VoidCallback onBack;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final Color foreground = isDark ? Colors.white : const Color(0xFF111827);

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
              color: foreground,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            'Notifications',
            style: TextStyle(
              color: foreground,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),
        ),
      ],
    );
  }
}
