import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/vibe_preferences_model.dart';

class VibeSocialTrustCard extends StatelessWidget {
  const VibeSocialTrustCard({super.key});

  @override
  Widget build(BuildContext context) {
    final items = VibeTrustItem.defaults;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEAE8E2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _TrustTile(item: items[0])),
              Expanded(child: _TrustTile(item: items[1])),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _TrustTile(item: items[2])),
              Expanded(child: _TrustTile(item: items[3])),
            ],
          ),
          const SizedBox(height: 18),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialIcon(
                icon: FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Color(0xFF1877F2),
                  size: 18,
                ),
              ),
              SizedBox(width: 12),
              _SocialIcon(
                icon: ShaderMask(
                  shaderCallback: _instagramShader,
                  child: FaIcon(
                    FontAwesomeIcons.instagram,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
              SizedBox(width: 12),
              _SocialIcon(
                icon: FaIcon(
                  FontAwesomeIcons.tiktok,
                  color: Colors.black,
                  size: 17,
                ),
              ),
              SizedBox(width: 12),
              _SocialIcon(
                icon: FaIcon(
                  FontAwesomeIcons.linkedin,
                  color: Color(0xFF0A66C2),
                  size: 18,
                ),
              ),
            ],
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

class _TrustTile extends StatelessWidget {
  const _TrustTile({required this.item});

  final VibeTrustItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(item.icon, color: const Color(0xFF16A34A), size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            item.label,
            style: const TextStyle(
              color: Color(0xFF374151),
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({required this.icon});

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFF6F5F1),
        border: Border.all(color: const Color(0xFFEAE8E2)),
      ),
      alignment: Alignment.center,
      child: icon,
    );
  }
}
