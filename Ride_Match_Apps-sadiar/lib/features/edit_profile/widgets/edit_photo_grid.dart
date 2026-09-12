import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';

class EditPhotoGrid extends StatelessWidget {
  const EditPhotoGrid({
    super.key,
    required this.onEditPhoto,
    required this.onAddMore,
    this.isDark = false,
  });

  final ValueChanged<int> onEditPhoto;
  final VoidCallback onAddMore;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final buttonBg = isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6);
    final buttonFg = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: _PhotoTile(
                  asset: AppAssets.profileHero,
                  alignment: Alignment.center,
                  onEdit: () => onEditPhoto(0),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Expanded(
                      child: _PhotoTile(
                        asset: AppAssets.profileHero,
                        alignment: const Alignment(-0.2, -0.4),
                        onEdit: () => onEditPhoto(1),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: _PhotoTile(
                        asset: AppAssets.profileHero,
                        alignment: const Alignment(0.25, 0.35),
                        onEdit: () => onEditPhoto(2),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: onAddMore,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonBg,
              foregroundColor: buttonFg,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Add more +',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({
    required this.asset,
    required this.alignment,
    required this.onEdit,
  });

  final String asset;
  final Alignment alignment;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            asset,
            fit: BoxFit.cover,
            alignment: alignment,
          ),
        ),
        Positioned(
          right: 8,
          bottom: 8,
          child: InkWell(
            onTap: onEdit,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.button,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit_rounded,
                size: 16,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
