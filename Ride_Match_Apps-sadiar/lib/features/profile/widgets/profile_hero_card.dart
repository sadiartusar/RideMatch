import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ProfileHeroCard extends StatelessWidget {
  const ProfileHeroCard({
    super.key,
    required this.name,
    required this.headline,
    required this.badgeLabel,
    this.imageAsset,
    this.imageUrl,
  });

  final String name;
  final String headline;
  final String badgeLabel;
  final String? imageAsset;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.92,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _HeroImage(imageAsset: imageAsset, imageUrl: imageUrl),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Color(0x99000000),
                    Color(0xCC000000),
                  ],
                  stops: [0.0, 0.45, 0.75, 1.0],
                ),
              ),
            ),
            Positioned(
              left: 18,
              right: 18,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.button,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            size: 12,
                            color: Color(0xFF15803D),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          badgeLabel,
                          style: const TextStyle(
                            color: Color(0xFF0F172A),
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    headline,
                    style: const TextStyle(
                      color: Color(0xFFE5E7EB),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({this.imageAsset, this.imageUrl});

  final String? imageAsset;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageAsset != null && imageAsset!.isNotEmpty) {
      return Image.asset(
        imageAsset!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const _HeroPlaceholder(),
      );
    }
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const _HeroPlaceholder(),
      );
    }
    return const _HeroPlaceholder();
  }
}

class _HeroPlaceholder extends StatelessWidget {
  const _HeroPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1F2937), Color(0xFF111827)],
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.person_rounded,
          size: 120,
          color: Color(0xFF6B7280),
        ),
      ),
    );
  }
}
