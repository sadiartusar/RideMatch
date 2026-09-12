import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/user_profile_model.dart';

class UserProfileSocialTrust extends StatelessWidget {
  const UserProfileSocialTrust({
    super.key,
    required this.profile,
    required this.onSocialTap,
  });

  final UserProfileModel profile;
  final ValueChanged<UserProfileSocialLink> onSocialTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEAE8E2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Social Trust',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              if (profile.nidVerified)
                const Expanded(
                  child: _TrustChip(label: 'NID Verified'),
                ),
              if (profile.nidVerified && profile.licenseVerified)
                const SizedBox(width: 10),
              if (profile.licenseVerified)
                const Expanded(
                  child: _TrustChip(label: 'License Verified'),
                ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'SOCIAL LINKS:',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),
          for (var i = 0; i < profile.socialLinks.length; i++) ...[
            _SocialLinkTile(
              link: profile.socialLinks[i],
              onTap: () => onSocialTap(profile.socialLinks[i]),
            ),
            if (i != profile.socialLinks.length - 1) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _TrustChip extends StatelessWidget {
  const _TrustChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: Color(0xFF16A34A),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 12,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF111827),
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialLinkTile extends StatelessWidget {
  const _SocialLinkTile({
    required this.link,
    required this.onTap,
  });

  final UserProfileSocialLink link;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE8E6E0)),
          ),
          child: Row(
            children: [
              _iconFor(link.platform),
              const SizedBox(width: 12),
              Text(
                link.label,
                style: const TextStyle(
                  color: Color(0xFF1F2937),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _iconFor(UserProfileSocialPlatform platform) {
  return switch (platform) {
    UserProfileSocialPlatform.facebook => const FaIcon(
        FontAwesomeIcons.facebook,
        color: Color(0xFF1877F2),
        size: 18,
      ),
    UserProfileSocialPlatform.instagram => const ShaderMask(
        shaderCallback: _instagramShader,
        child: FaIcon(
          FontAwesomeIcons.instagram,
          color: Colors.white,
          size: 18,
        ),
      ),
    UserProfileSocialPlatform.tiktok => const FaIcon(
        FontAwesomeIcons.tiktok,
        color: Colors.black,
        size: 16,
      ),
    UserProfileSocialPlatform.linkedin => const FaIcon(
        FontAwesomeIcons.linkedin,
        color: Color(0xFF0A66C2),
        size: 18,
      ),
  };
}

Shader _instagramShader(Rect bounds) {
  return const LinearGradient(
    colors: [
      Color(0xFF833AB4),
      Color(0xFFFD1D1D),
      Color(0xFFFCAF45),
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  ).createShader(bounds);
}
