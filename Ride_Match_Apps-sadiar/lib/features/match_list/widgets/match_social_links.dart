import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/driver_match_model.dart';

class MatchSocialLinks extends StatelessWidget {
  const MatchSocialLinks({
    super.key,
    required this.links,
    required this.onTap,
    this.tileHeight = 42,
  });

  final List<DriverSocialLink> links;
  final ValueChanged<DriverSocialLink> onTap;
  final double tileHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SOCIAL LINKS:',
          style: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.7,
          ),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: links.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            mainAxisExtent: tileHeight,
          ),
          itemBuilder: (context, index) {
            final link = links[index];
            return _SocialLinkButton(
              link: link,
              onTap: () => onTap(link),
            );
          },
        ),
      ],
    );
  }
}

class _SocialLinkButton extends StatelessWidget {
  const _SocialLinkButton({
    required this.link,
    required this.onTap,
  });

  final DriverSocialLink link;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE8E6E0)),
          ),
          child: Row(
            children: [
              _iconFor(link.platform),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  link.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconFor(DriverSocialPlatform platform) {
    return switch (platform) {
      DriverSocialPlatform.facebook => const FaIcon(
          FontAwesomeIcons.facebook,
          color: Color(0xFF1877F2),
          size: 16,
        ),
      DriverSocialPlatform.instagram => const ShaderMask(
          shaderCallback: _instagramShader,
          child: FaIcon(
            FontAwesomeIcons.instagram,
            color: Colors.white,
            size: 16,
          ),
        ),
      DriverSocialPlatform.tiktok => const FaIcon(
          FontAwesomeIcons.tiktok,
          color: Colors.black,
          size: 14,
        ),
      DriverSocialPlatform.linkedin => const FaIcon(
          FontAwesomeIcons.linkedin,
          color: Color(0xFF0A66C2),
          size: 16,
        ),
    };
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
