import 'package:flutter/material.dart';

import 'user_mode.dart';

/// Static content for a Choose Mode card.
class ModeOption {
  const ModeOption({
    required this.mode,
    required this.title,
    required this.description,
    required this.tags,
    required this.buttonLabel,
    required this.icon,
  });

  final UserMode mode;
  final String title;
  final String description;
  final List<String> tags;
  final String buttonLabel;
  final IconData icon;

  static const List<ModeOption> all = [
    ModeOption(
      mode: UserMode.flex,
      title: 'Flex',
      description:
          'Ride and drive in one place. Let the app suggest the best mode. '
          'Switch instantly anytime.',
      tags: ['Earn coupons', 'Offer seats', 'Route control'],
      buttonLabel: 'Choose Flex',
      icon: Icons.swap_horiz_rounded,
    ),
    ModeOption(
      mode: UserMode.rider,
      title: 'Rider',
      description:
          'Book a ride with coupons. Use your Travel Wallet. '
          'Find matched drivers nearby.',
      tags: ['Spend coupons', 'Find matches', 'Social discovery'],
      buttonLabel: 'Choose Rider',
      icon: Icons.hail_rounded,
    ),
    ModeOption(
      mode: UserMode.driver,
      title: 'Driver',
      description:
          'Offer seats on your routes. Receive coupons and rewards. '
          'Use your Driver Wallet.',
      tags: ['Earn coupons', 'Offer seats', 'Route control'],
      buttonLabel: 'Choose Driver',
      icon: Icons.directions_car_filled_rounded,
    ),
  ];
}
