import 'package:flutter/material.dart';

import '../models/commute_circle_model.dart';

class DriverCommuteCirclesGrid extends StatelessWidget {
  const DriverCommuteCirclesGrid({
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                'Commute Circles',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onViewAll,
              child: const Text(
                'View all',
                style: TextStyle(
                  color: Color(0xFF32E116),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
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
          color: const Color(0xFF171A1D),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF262B32),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFF22262C),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                circle.icon,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              circle.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              circle.memberCount,
              style: const TextStyle(
                color: Color(0xFF32E116),
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
