import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class SocialTrustPreviewCard extends StatelessWidget {
  const SocialTrustPreviewCard({
    super.key,
    required this.trustScore,
    required this.avatarUrls,
    required this.extraCount,
  });

  final int trustScore;
  final List<String> avatarUrls;
  final int extraCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'Social Trust Preview',
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$trustScore%',
                    style: const TextStyle(
                      color: AppColors.button,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Trust Score',
                    style: TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Icon(
                Icons.verified_rounded,
                color: AppColors.button,
                size: 18,
              ),
              SizedBox(width: 8),
              Text(
                'Verified Identity',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              SizedBox(
                width: 96,
                height: 32,
                child: Stack(
                  children: [
                    for (var i = 0; i < avatarUrls.length; i++)
                      Positioned(
                        left: i * 20.0,
                        child: _AvatarCircle(
                          child: ClipOval(
                            child: Image.network(
                              avatarUrls[i],
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 32,
                                height: 32,
                                color: const Color(0xFFE5E7EB),
                                alignment: Alignment.center,
                                child: Text(
                                  String.fromCharCode(65 + i),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      left: avatarUrls.length * 20.0,
                      child: _AvatarCircle(
                        child: Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          color: const Color(0xFFF3F4F6),
                          child: Text(
                            '+$extraCount',
                            style: const TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Mutual circles',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AvatarCircle extends StatelessWidget {
  const _AvatarCircle({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
