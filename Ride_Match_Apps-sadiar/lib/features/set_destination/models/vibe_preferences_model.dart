import 'package:flutter/material.dart';

enum VibeMood { quiet, openToConversation }

enum VibeMusic { on, off }

enum VibeIntent { networking, socializing }

class VibeCircleOption {
  const VibeCircleOption({
    required this.id,
    required this.name,
    required this.memberCount,
    required this.icon,
  });

  final String id;
  final String name;
  final String memberCount;
  final IconData icon;

  static const List<VibeCircleOption> defaults = [
    VibeCircleOption(
      id: 'french_speakers',
      name: 'French Speakers',
      memberCount: '1.2k members',
      icon: Icons.translate_rounded,
    ),
    VibeCircleOption(
      id: 'tech_enthusiasts',
      name: 'Tech Enthusiasts',
      memberCount: '3.1k members',
      icon: Icons.memory_rounded,
    ),
    VibeCircleOption(
      id: 'foodies_unites',
      name: 'Foodies Unites',
      memberCount: '2.5k members',
      icon: Icons.lunch_dining_rounded,
    ),
    VibeCircleOption(
      id: 'women_only',
      name: 'Women-only',
      memberCount: '1.7k members',
      icon: Icons.female_rounded,
    ),
  ];
}

class VibeTrustItem {
  const VibeTrustItem({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  static const List<VibeTrustItem> defaults = [
    VibeTrustItem(label: 'Verified ID', icon: Icons.verified_user_outlined),
    VibeTrustItem(label: 'Mutual Communities', icon: Icons.groups_outlined),
    VibeTrustItem(label: 'Connected Social', icon: Icons.share_outlined),
    VibeTrustItem(label: 'Repeat Ride', icon: Icons.repeat_rounded),
  ];
}
