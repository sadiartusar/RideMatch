import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/community_circle_model.dart';

class CommunityCircleCard extends StatelessWidget {
  const CommunityCircleCard({
    super.key,
    required this.circle,
    required this.onJoinTap,
    required this.onViewDetails,
    this.isDark = false,
  });

  final CommunityCircleModel circle;
  final VoidCallback onJoinTap;
  final VoidCallback onViewDetails;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF16181B) : Colors.white;
    final border =
        isDark ? const Color(0xFF2C333A) : const Color(0xFFE5E7EB);
    final titleColor = isDark ? Colors.white : const Color(0xFF111827);
    final muted = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

    return Material(
      color: cardBg,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: border),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          circle.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: titleColor,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _AvatarStack(
                        urls: circle.avatarUrls.take(3).toList(),
                        extraLabel: circle.extraMembersLabel,
                        isDark: isDark,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Icon(Icons.groups_outlined, size: 18, color: muted),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          circle.membersLabel,
                          style: TextStyle(
                            color: muted,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _JoinChip(
                        label: circle.isJoined ? 'Joined' : 'Join',
                        onTap: onJoinTap,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(height: 1, thickness: 1, color: border),
            InkWell(
              onTap: onViewDetails,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(17),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'View Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: muted,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JoinChip extends StatelessWidget {
  const _JoinChip({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.button,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.buttonForeground,
              fontSize: 13.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  const _AvatarStack({
    required this.urls,
    required this.extraLabel,
    required this.isDark,
  });

  final List<String> urls;
  final String extraLabel;
  final bool isDark;

  static const double _size = 28;
  static const double _step = 18;

  @override
  Widget build(BuildContext context) {
    final count = urls.length;
    final width = _size + (count * _step);

    return SizedBox(
      width: width,
      height: _size,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          for (var i = 0; i < count; i++)
            Positioned(
              left: i * _step,
              top: 0,
              width: _size,
              height: _size,
              child: _AvatarBubble(url: urls[i]),
            ),
          Positioned(
            left: count * _step,
            top: 0,
            width: _size,
            height: _size,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1B1E23)
                    : const Color(0xFFE5E7EB),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? const Color(0xFF16181B) : Colors.white,
                  width: 1.5,
                ),
              ),
              child: Text(
                extraLabel,
                style: TextStyle(
                  color: isDark
                      ? const Color(0xFF9CA3AF)
                      : const Color(0xFF4B5563),
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarBubble extends StatelessWidget {
  const _AvatarBubble({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFE5E7EB),
        border: Border.all(color: Colors.white, width: 1.5),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
          onError: (_, _) {},
        ),
      ),
    );
  }
}
