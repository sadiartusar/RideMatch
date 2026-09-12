import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/user_profile_model.dart';
import 'user_profile_section_label.dart';

class UserProfileAbout extends StatelessWidget {
  const UserProfileAbout({
    super.key,
    required this.about,
  });

  final String about;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UserProfileSectionLabel('ABOUT'),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F6),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            '"$about"',
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
              fontStyle: FontStyle.italic,
              height: 1.45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class UserProfileReviews extends StatelessWidget {
  const UserProfileReviews({
    super.key,
    required this.reviews,
    required this.onViewAll,
  });

  final List<UserProfileReview> reviews;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: UserProfileSectionLabel('REVIEWS'),
            ),
            GestureDetector(
              onTap: onViewAll,
              child: const Text(
                'VIEW ALL',
                style: TextStyle(
                  color: AppColors.success,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < reviews.length; i++) ...[
          if (i > 0) const SizedBox(height: 16),
          _ReviewTile(review: reviews[i]),
        ],
      ],
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.review});

  final UserProfileReview review;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.asset(
            review.avatarAsset,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 40,
                height: 40,
                color: const Color(0xFFE5E7EB),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.person_rounded,
                  size: 22,
                  color: Color(0xFF9CA3AF),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      review.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: List.generate(
                      review.rating.round().clamp(0, 5),
                      (index) => const Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: Color(0xFFF5C518),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '"${review.quote}"',
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 13,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
