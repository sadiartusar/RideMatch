import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';

class MatchTrustSection extends StatelessWidget {
  const MatchTrustSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(12, 12, 14, 12),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF8C8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFBBF7D0)),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.verified_rounded,
                color: Color(0xFF16A34A),
                size: 28,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'High rating and verified profile',
                      style: TextStyle(
                        color: Color(0xFF166534),
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Top 1% of partners this month',
                      style: TextStyle(
                        color: Color(0xFF15803D),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Passenger reviews',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Excellent',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            _ReviewAvatars(),
          ],
        ),
      ],
    );
  }
}

class _ReviewAvatars extends StatelessWidget {
  const _ReviewAvatars();

  static const List<String> _assets = [
    AppAssets.profileHero,
    AppAssets.profileGallery1,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 92,
      height: 34,
      child: Stack(
        children: [
          for (var i = 0; i < _assets.length; i++)
            Positioned(
              left: i * 20.0,
              child: _AvatarBubble(asset: _assets[i]),
            ),
          const Positioned(
            left: 40,
            child: _CountBubble(),
          ),
        ],
      ),
    );
  }
}

class _AvatarBubble extends StatelessWidget {
  const _AvatarBubble({required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: ClipOval(
        child: Image.asset(
          asset,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const ColoredBox(
              color: Color(0xFFD1D5DB),
              child: Icon(Icons.person, size: 16, color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}

class _CountBubble extends StatelessWidget {
  const _CountBubble();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF8BE55A),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: const Text(
        '+42',
        style: TextStyle(
          color: Color(0xFF111827),
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
