import 'package:flutter/material.dart';

class CouponTaskModel {
  const CouponTaskModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.badgeText,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final String? badgeText;

  static const List<CouponTaskModel> defaults = [
    CouponTaskModel(
      id: 'watch_and_answer',
      title: 'Watch & Answer',
      subtitle: 'Complete a short safety video quiz.',
      icon: Icons.smart_display_rounded,
      badgeText: '+25',
    ),
    CouponTaskModel(
      id: 'invite_a_friend',
      title: 'Invite a Friend',
      subtitle: 'When they complete ride.',
      icon: Icons.person_add_alt_1_rounded,
    ),
    CouponTaskModel(
      id: 'profile_bonus',
      title: 'Profile Complete',
      subtitle: 'Add emergency contact & ID.',
      icon: Icons.verified_user_rounded,
      badgeText: '+50',
    ),
  ];
}
