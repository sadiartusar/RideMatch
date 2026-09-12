import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/connection_models.dart';

class ConnectionFriendCard extends StatelessWidget {
  const ConnectionFriendCard({
    super.key,
    required this.friend,
    required this.onChat,
    required this.onProfile,
    required this.onUnfriend,
    this.isDark = false,
  });

  final ConnectionFriend friend;
  final VoidCallback onChat;
  final VoidCallback onProfile;
  final VoidCallback onUnfriend;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF16181B) : Colors.white;
    final border =
        isDark ? const Color(0xFF2C333A) : const Color(0xFFE5E7EB);
    final titleColor = isDark ? Colors.white : const Color(0xFF111827);
    final muted = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final chatBg =
        isDark ? const Color(0xFF1B3A1D) : const Color(0xFFDCFCE7);
    final menuBg =
        isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.network(
              friend.avatarUrl,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              gaplessPlayback: true,
              errorBuilder: (_, _, _) => Container(
                width: 56,
                height: 56,
                color: menuBg,
                alignment: Alignment.center,
                child: const Icon(Icons.person, color: Color(0xFF9CA3AF)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        friend.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    if (friend.isVerified) ...[
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.verified_rounded,
                        size: 16,
                        color: Color(0xFF16A34A),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.groups_outlined, size: 15, color: muted),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        friend.statsLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: muted,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _RoundIconButton(
            background: chatBg,
            icon: Icons.chat_bubble_outline_rounded,
            iconColor: isDark ? AppColors.button : const Color(0xFF15803D),
            onTap: onChat,
          ),
          const SizedBox(width: 8),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'profile') onProfile();
              if (value == 'unfriend') onUnfriend();
            },
            offset: const Offset(0, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: isDark ? const Color(0xFF1B1E23) : Colors.white,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(
                      Icons.person_outline_rounded,
                      size: 18,
                      color: isDark ? Colors.white : const Color(0xFF111827),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Profile',
                      style: TextStyle(
                        color:
                            isDark ? Colors.white : const Color(0xFF111827),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'unfriend',
                child: Row(
                  children: [
                    Icon(
                      Icons.person_remove_outlined,
                      size: 18,
                      color: Color(0xFFDC2626),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Unfriend',
                      style: TextStyle(
                        color: Color(0xFFDC2626),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: menuBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.more_vert_rounded,
                size: 18,
                color: muted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.background,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  final Color background;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(icon, size: 18, color: iconColor),
        ),
      ),
    );
  }
}
