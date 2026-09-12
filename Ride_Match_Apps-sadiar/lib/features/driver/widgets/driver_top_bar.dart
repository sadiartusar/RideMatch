import 'package:flutter/material.dart';

class DriverTopBar extends StatelessWidget {
  const DriverTopBar({
    super.key,
    required this.name,
    this.verificationStatus = 'NOT VERIFIED MEMBER',
    required this.onNotificationTap,
    required this.onMenuTap,
  });

  final String name;
  final String verificationStatus;
  final VoidCallback onNotificationTap;
  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar with vivid green ring
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF32E116),
              width: 2,
            ),
          ),
          child: ClipOval(
            child: Container(
              color: const Color(0xFF1F2937),
              child: const Icon(
                Icons.person_rounded,
                color: Color(0xFF9CA3AF),
                size: 28,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Name & Verification Badge
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                verificationStatus,
                style: const TextStyle(
                  color: Color(0xFF32E116),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
        // Notification bell with red badge
        _CircularActionButton(
          onTap: onNotificationTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
                size: 22,
              ),
              Positioned(
                right: 1,
                top: 1,
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
        // Menu button
        _CircularActionButton(
          onTap: onMenuTap,
          child: const Icon(
            Icons.menu_rounded,
            color: Colors.white,
            size: 22,
          ),
        ),
      ],
    );
  }
}

class _CircularActionButton extends StatelessWidget {
  const _CircularActionButton({
    required this.child,
    required this.onTap,
  });

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFF1B1E22),
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF262B32),
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
