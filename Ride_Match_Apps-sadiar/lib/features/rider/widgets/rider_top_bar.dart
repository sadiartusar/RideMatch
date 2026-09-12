import 'package:flutter/material.dart';

class RiderTopBar extends StatelessWidget {
  const RiderTopBar({
    super.key,
    required this.name,
    this.verificationStatus = 'VERIFIED MEMBER',
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
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF16A34A),
              width: 2.2,
            ),
          ),
          child: ClipOval(
            child: Container(
              color: const Color(0xFFE2E8F0),
              child: const Icon(
                Icons.person_rounded,
                color: Color(0xFF475569),
                size: 30,
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
                  color: Color(0xFF111827),
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                verificationStatus,
                style: const TextStyle(
                  color: Color(0xFF15803D),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
        // Notification bell with red badge dot
        _CircularActionButton(
          onTap: onNotificationTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.notifications_none_rounded,
                color: Color(0xFF1F2937),
                size: 22,
              ),
              Positioned(
                right: 1,
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
        // Hamburger Menu button
        _CircularActionButton(
          onTap: onMenuTap,
          child: const Icon(
            Icons.menu_rounded,
            color: Color(0xFF1F2937),
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
          color: const Color(0xFFECEAE4),
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFFE0DDD6),
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
