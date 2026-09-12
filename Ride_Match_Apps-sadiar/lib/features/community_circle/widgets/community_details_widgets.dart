import 'package:flutter/material.dart';

import '../models/community_circle_model.dart';

class CommunityMemberCard extends StatelessWidget {
  const CommunityMemberCard({
    super.key,
    required this.member,
    this.isDark = false,
  });

  final CommunityCircleMember member;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF16181B) : Colors.white;
    final border =
        isDark ? const Color(0xFF2C333A) : const Color(0xFFE5E7EB);
    final nameColor = isDark ? Colors.white : const Color(0xFF111827);

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.network(
              member.avatarUrl,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              gaplessPlayback: true,
              errorBuilder: (_, _, _) => Container(
                width: 56,
                height: 56,
                color: isDark
                    ? const Color(0xFF1B1E23)
                    : const Color(0xFFE5E7EB),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.person_rounded,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            member.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: nameColor,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class CommunityStatCard extends StatelessWidget {
  const CommunityStatCard({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.isDark = false,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF16181B) : Colors.white;
    final border =
        isDark ? const Color(0xFF2C333A) : const Color(0xFFE5E7EB);
    final labelColor =
        isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final defaultValue =
        isDark ? Colors.white : const Color(0xFF111827);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? defaultValue,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}
