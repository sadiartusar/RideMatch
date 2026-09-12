import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RiderSocialTrustCard extends StatelessWidget {
  const RiderSocialTrustCard({
    super.key,
    required this.onPlatformTap,
  });

  final ValueChanged<String> onPlatformTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEAE8E2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Social Trust',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'SOCIAL LINKS:',
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),
          _SocialLinkTile(
            platform: 'Facebook',
            label: 'Facebook Connected',
            icon: const FaIcon(
              FontAwesomeIcons.facebook,
              color: Color(0xFF1877F2),
              size: 20,
            ),
            onTap: () => onPlatformTap('Facebook'),
          ),
          const SizedBox(height: 10),
          _SocialLinkTile(
            platform: 'Instagram',
            label: 'Instagram Connected',
            icon: const ShaderMask(
              shaderCallback: _instagramShader,
              child: FaIcon(
                FontAwesomeIcons.instagram,
                color: Colors.white,
                size: 20,
              ),
            ),
            onTap: () => onPlatformTap('Instagram'),
          ),
          const SizedBox(height: 10),
          _SocialLinkTile(
            platform: 'TikTok',
            label: 'TikTok Connected',
            icon: const FaIcon(
              FontAwesomeIcons.tiktok,
              color: Colors.black,
              size: 19,
            ),
            onTap: () => onPlatformTap('TikTok'),
          ),
          const SizedBox(height: 10),
          _SocialLinkTile(
            platform: 'LinkedIn',
            label: 'LinkedIn Connected',
            icon: const FaIcon(
              FontAwesomeIcons.linkedin,
              color: Color(0xFF0A66C2),
              size: 20,
            ),
            onTap: () => onPlatformTap('LinkedIn'),
          ),
        ],
      ),
    );
  }

  static Shader _instagramShader(Rect bounds) {
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
}

class _SocialLinkTile extends StatelessWidget {
  const _SocialLinkTile({
    required this.platform,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String platform;
  final String label;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F5F1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFFE8E5DD),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF1F2937),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
