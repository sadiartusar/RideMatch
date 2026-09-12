import 'package:flutter/material.dart';

enum DrawerNavId {
  home,
  wallet,
  missions,
  connections,
  friendsFeed,
  communityCircles,
  profile,
  rideHistory,
  marketplace,
  notifications,
  settings,
  language,
  logout,
}

class DrawerNavItem {
  const DrawerNavItem({
    required this.id,
    required this.label,
    required this.icon,
    this.isDestructive = false,
  });

  final DrawerNavId id;
  final String label;
  final IconData icon;
  final bool isDestructive;

  static const List<DrawerNavItem> primary = [
    DrawerNavItem(
      id: DrawerNavId.home,
      label: 'Home',
      icon: Icons.home_outlined,
    ),
    DrawerNavItem(
      id: DrawerNavId.wallet,
      label: 'Wallet',
      icon: Icons.account_balance_wallet_outlined,
    ),
    DrawerNavItem(
      id: DrawerNavId.missions,
      label: 'Missions',
      icon: Icons.emoji_events_outlined,
    ),
    DrawerNavItem(
      id: DrawerNavId.connections,
      label: 'Connections',
      icon: Icons.hub_outlined,
    ),
    DrawerNavItem(
      id: DrawerNavId.friendsFeed,
      label: 'Friends Feed',
      icon: Icons.people_outline_rounded,
    ),
    DrawerNavItem(
      id: DrawerNavId.communityCircles,
      label: 'Community Circles',
      icon: Icons.workspaces_outlined,
    ),
    DrawerNavItem(
      id: DrawerNavId.profile,
      label: 'Profile',
      icon: Icons.person_outline_rounded,
    ),
    DrawerNavItem(
      id: DrawerNavId.rideHistory,
      label: 'Ride History',
      icon: Icons.history_rounded,
    ),
    DrawerNavItem(
      id: DrawerNavId.marketplace,
      label: 'Marketplace',
      icon: Icons.storefront_outlined,
    ),
    DrawerNavItem(
      id: DrawerNavId.notifications,
      label: 'Notifications',
      icon: Icons.notifications_none_rounded,
    ),
  ];

  static const List<DrawerNavItem> preferences = [
    DrawerNavItem(
      id: DrawerNavId.settings,
      label: 'Settings',
      icon: Icons.settings_outlined,
    ),
    DrawerNavItem(
      id: DrawerNavId.language,
      label: 'Language',
      icon: Icons.translate_rounded,
    ),
    DrawerNavItem(
      id: DrawerNavId.logout,
      label: 'Log out',
      icon: Icons.logout_rounded,
      isDestructive: true,
    ),
  ];
}
