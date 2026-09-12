import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';

class DrawerProfileHeader extends StatelessWidget {
  const DrawerProfileHeader({
    super.key,
    required this.name,
    this.isVerified = true,
    this.avatarUrl,
    this.onProfileTap,
    this.isDark = false,
  });

  final String name;
  final bool isVerified;
  final String? avatarUrl;
  final VoidCallback? onProfileTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final nameColor = isDark ? Colors.white : AppColors.buttonForeground;
    final panelColor = isDark ? const Color(0xFF16181B) : Colors.white;

    return GestureDetector(
      onTap: onProfileTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.button,
                    width: 3,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: avatarUrl != null && avatarUrl!.isNotEmpty
                      ? Image.network(
                          avatarUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            AppAssets.profileHero,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          AppAssets.profileHero,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _AvatarFallback(isDark: isDark),
                        ),
                ),
              ),
              if (isVerified)
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                      border: Border.all(color: panelColor, width: 2),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          if (isVerified)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFBBF24),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'VERIFIED',
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          if (isVerified) const SizedBox(height: 8),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: nameColor,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarFallback extends StatelessWidget {
  const _AvatarFallback({this.isDark = false});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDark ? const Color(0xFF1B1E23) : AppColors.infoBackground,
      child: Icon(
        Icons.person_rounded,
        color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
        size: 40,
      ),
    );
  }
}
