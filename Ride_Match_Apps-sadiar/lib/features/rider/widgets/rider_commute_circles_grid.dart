import 'package:flutter/material.dart';

import '../../driver/models/commute_circle_model.dart';

class RiderCommuteCirclesGrid extends StatelessWidget {
  const RiderCommuteCirclesGrid({
    super.key,
    required this.circles,
    required this.onViewAll,
    required this.onCircleTap,
  });

  final List<CommuteCircleModel> circles;
  final VoidCallback onViewAll;
  final ValueChanged<CommuteCircleModel> onCircleTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                'Commute Circles',
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onViewAll,
              behavior: HitTestBehavior.opaque,
              child: const Text(
                'View all',
                style: TextStyle(
                  color: Color(0xFF16A34A),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        // 2x2 Grid
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: circles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.12,
          ),
          itemBuilder: (context, index) {
            final circle = circles[index];
            return _CircleGridItem(
              circle: circle,
              onTap: () => onCircleTap(circle),
            );
          },
        ),
      ],
    );
  }
}

class _CircleGridItem extends StatelessWidget {
  const _CircleGridItem({
    required this.circle,
    required this.onTap,
  });

  final CommuteCircleModel circle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFEAE8E2),
            width: 1,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFFF1F0EB),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                circle.icon,
                color: const Color(0xFF1F2937),
                size: 22,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              circle.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF111827),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              circle.memberCount,
              style: const TextStyle(
                color: Color(0xFF16A34A),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
