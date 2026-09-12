import 'package:flutter/material.dart';

enum CommuteModeType { rideRequest, offerSeats }

class CommuteModeFeature {
  const CommuteModeFeature({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}

class CommuteModeOption {
  const CommuteModeOption({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.features,
  });

  final CommuteModeType type;
  final String title;
  final String subtitle;
  final IconData icon;
  final List<CommuteModeFeature> features;

  static const List<CommuteModeOption> defaults = [
    CommuteModeOption(
      type: CommuteModeType.rideRequest,
      title: 'Ride Request',
      subtitle: 'Find a match for your commute instantly.',
      icon: Icons.hail_rounded,
      features: [
        CommuteModeFeature(
          icon: Icons.account_balance_wallet_outlined,
          label: 'Use Travel Wallet',
        ),
        CommuteModeFeature(
          icon: Icons.near_me_outlined,
          label: 'Search nearby drivers',
        ),
      ],
    ),
    CommuteModeOption(
      type: CommuteModeType.offerSeats,
      title: 'Offer Seats',
      subtitle: 'Monetize your journey and help others.',
      icon: Icons.directions_car_filled_rounded,
      features: [
        CommuteModeFeature(
          icon: Icons.route_outlined,
          label: 'Set your route',
        ),
        CommuteModeFeature(
          icon: Icons.payments_outlined,
          label: 'Earn receiving wallet value',
        ),
      ],
    ),
  ];
}
