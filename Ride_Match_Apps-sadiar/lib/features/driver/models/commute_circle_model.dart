import 'package:flutter/material.dart';

class CommuteCircleModel {
  const CommuteCircleModel({
    required this.id,
    required this.name,
    required this.memberCount,
    required this.icon,
  });

  final String id;
  final String name;
  final String memberCount;
  final IconData icon;

  static const List<CommuteCircleModel> defaults = [
    CommuteCircleModel(
      id: 'french_speakers',
      name: 'French Speakers',
      memberCount: '1.2k members',
      icon: Icons.translate_rounded,
    ),
    CommuteCircleModel(
      id: 'tech_enthusiasts',
      name: 'Tech Enthusiasts',
      memberCount: '3.1k members',
      icon: Icons.memory_rounded,
    ),
    CommuteCircleModel(
      id: 'foodies_unites',
      name: 'Foodies Unites',
      memberCount: '2.5k members',
      icon: Icons.lunch_dining_rounded,
    ),
    CommuteCircleModel(
      id: 'women_only',
      name: 'Women-only',
      memberCount: '1.7k members',
      icon: Icons.female_rounded,
    ),
  ];
}
