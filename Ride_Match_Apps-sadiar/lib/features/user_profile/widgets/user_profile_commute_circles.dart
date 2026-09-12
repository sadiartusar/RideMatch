import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/user_profile_model.dart';
import 'user_profile_section_label.dart';

class UserProfileCommuteCircles extends StatelessWidget {
  const UserProfileCommuteCircles({
    super.key,
    required this.circles,
    required this.onCircleTap,
  });

  final List<UserProfileCircle> circles;
  final ValueChanged<UserProfileCircle> onCircleTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UserProfileSectionLabel('COMMUTE CIRCLES'),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: circles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 132,
          ),
          itemBuilder: (context, index) {
            final circle = circles[index];
            return _CircleCard(
              circle: circle,
              onTap: () => onCircleTap(circle),
            );
          },
        ),
      ],
    );
  }
}

class _CircleCard extends StatelessWidget {
  const _CircleCard({
    required this.circle,
    required this.onTap,
  });

  final UserProfileCircle circle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFEAE8E2)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFF3F4F6),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  circle.icon,
                  color: const Color(0xFF111827),
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
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                circle.memberCount,
                style: const TextStyle(
                  color: AppColors.success,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
