import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/user_profile_controller.dart';
import '../models/user_profile_model.dart';

class UserProfileHero extends StatelessWidget {
  const UserProfileHero({
    super.key,
    required this.profile,
    required this.controller,
  });

  final UserProfileModel profile;
  final UserProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AvatarBadge(
          asset: profile.avatarAsset,
          isVerified: profile.isVerified,
        ),
        const SizedBox(height: 16),
        Text(
          profile.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF111827),
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '"${profile.headline}"',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 13.5,
            fontStyle: FontStyle.italic,
            height: 1.35,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            for (var i = 0; i < profile.stats.length; i++) ...[
              if (i > 0) const SizedBox(width: 10),
              Expanded(child: _StatCard(stat: profile.stats[i])),
            ],
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: profile.interests
              .map((tag) => _InterestChip(label: tag))
              .toList(),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: controller.callDriver,
                  icon: const Icon(Icons.call_rounded, size: 18),
                  label: const Text(
                    'Call Driver',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: const Color(0xFF111827),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: controller.openMessage,
                  icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18),
                  label: const Text(
                    'Message',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF16A34A),
                    side: const BorderSide(
                      color: Color(0xFF86EFAC),
                      width: 1.4,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AvatarBadge extends StatelessWidget {
  const _AvatarBadge({
    required this.asset,
    required this.isVerified,
  });

  final String asset;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      height: 136,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: 112,
            height: 112,
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.button,
            ),
            child: ClipOval(
              child: Image.asset(
                asset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const ColoredBox(
                    color: Color(0xFFE5E7EB),
                    child: Icon(
                      Icons.person_rounded,
                      size: 54,
                      color: Color(0xFF9CA3AF),
                    ),
                  );
                },
              ),
            ),
          ),
          if (isVerified)
            const Positioned(
              bottom: 8,
              child: _VerifiedPill(),
            ),
        ],
      ),
    );
  }
}

class _VerifiedPill extends StatelessWidget {
  const _VerifiedPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 5, 12, 5),
      decoration: BoxDecoration(
        color: const Color(0xFF14532D),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 14,
            height: 14,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.button,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.check_rounded,
                  color: Color(0xFF14532D),
                  size: 11,
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          Text(
            'VERIFIED',
            style: TextStyle(
              color: AppColors.button,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.stat});

  final UserProfileStat stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F0E8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            stat.value,
            style: const TextStyle(
              color: Color(0xFF7A6A3F),
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            stat.label,
            style: const TextStyle(
              color: Color(0xFFA39B8E),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _InterestChip extends StatelessWidget {
  const _InterestChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EDE5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF4A453C),
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
