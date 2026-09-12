import 'package:flutter/material.dart';

enum QuickRouteKind { primary, airport, recent }

class QuickRouteModel {
  const QuickRouteModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.kind,
    required this.icon,
    this.pickup,
    this.destination,
  });

  final String id;
  final String title;
  final String subtitle;
  final QuickRouteKind kind;
  final IconData icon;
  final String? pickup;
  final String? destination;

  static const List<QuickRouteModel> defaults = [
    QuickRouteModel(
      id: 'home_office',
      title: 'Home → Office',
      subtitle: '12.4 miles • 22 mins',
      kind: QuickRouteKind.primary,
      icon: Icons.work_outline_rounded,
      pickup: 'Home',
      destination: 'Office',
    ),
    QuickRouteModel(
      id: 'airport',
      title: 'Airport',
      subtitle: 'SFO Terminal 2',
      kind: QuickRouteKind.airport,
      icon: Icons.flight_takeoff_rounded,
      destination: 'SFO Terminal 2',
    ),
    QuickRouteModel(
      id: 'recent',
      title: 'Recent',
      subtitle: 'Golden Gate Park',
      kind: QuickRouteKind.recent,
      icon: Icons.history_rounded,
      destination: 'Golden Gate Park',
    ),
  ];
}
