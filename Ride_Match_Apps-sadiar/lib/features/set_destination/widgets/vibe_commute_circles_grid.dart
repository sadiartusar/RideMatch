import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/vibe_preferences_model.dart';

class VibeCommuteCirclesGrid extends StatelessWidget {
  const VibeCommuteCirclesGrid({
    super.key,
    required this.circles,
    required this.selectedId,
    required this.onCircleTap,
    required this.onShowAll,
  });

  final List<VibeCircleOption> circles;
  final String? selectedId;
  final ValueChanged<VibeCircleOption> onCircleTap;
  final VoidCallback onShowAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Commute Circles',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: circles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, index) {
            final circle = circles[index];
            final selected = selectedId == circle.id;
            return _CircleCard(
              circle: circle,
              selected: selected,
              onTap: () => onCircleTap(circle),
            );
          },
        ),
        const SizedBox(height: 14),
        Center(
          child: GestureDetector(
            onTap: onShowAll,
            behavior: HitTestBehavior.opaque,
            child: const Text(
              'Show All',
              style: TextStyle(
                color: Color(0xFF16A34A),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CircleCard extends StatelessWidget {
  const _CircleCard({
    required this.circle,
    required this.selected,
    required this.onTap,
  });

  final VibeCircleOption circle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? AppColors.button : Colors.white;
    final fg = selected ? AppColors.buttonForeground : const Color(0xFF111827);
    final sub = selected ? AppColors.buttonForeground : const Color(0xFF16A34A);

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? AppColors.button : const Color(0xFFEAE8E2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(circle.icon, color: fg, size: 26),
              const Spacer(),
              Text(
                circle.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: fg,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                circle.memberCount,
                style: TextStyle(
                  color: sub,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
