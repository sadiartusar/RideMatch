import 'package:flutter/material.dart';

import '../models/profile_model.dart';
import 'profile_theme_colors.dart';

class ProfileSocialLinks extends StatelessWidget {
  const ProfileSocialLinks({
    super.key,
    required this.links,
    required this.onTap,
    this.isDark = false,
  });

  final List<ProfileSocialLink> links;
  final ValueChanged<ProfileSocialLink> onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colors = ProfileThemeColors(isDark: isDark);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SOCIAL LINKS',
          style: TextStyle(
            color: colors.label,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.7,
          ),
        ),
        const SizedBox(height: 10),
        for (final link in links) ...[
          Material(
            color: colors.cardMuted,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              onTap: () => onTap(link),
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: colors.border),
                ),
                child: Row(
                  children: [
                    Icon(
                      _iconFor(link.icon),
                      size: 20,
                      color: colors.icon,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      link.label,
                      style: TextStyle(
                        color: colors.body,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }

  IconData _iconFor(ProfileSocialIcon icon) {
    return switch (icon) {
      ProfileSocialIcon.facebook => Icons.facebook_rounded,
      ProfileSocialIcon.instagram => Icons.camera_alt_outlined,
      ProfileSocialIcon.tiktok => Icons.music_note_rounded,
      ProfileSocialIcon.linkedin => Icons.business_center_outlined,
    };
  }
}
