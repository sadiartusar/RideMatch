import 'package:flutter/material.dart';

import '../../driver/widgets/driver_bottom_nav_bar.dart';
import '../../rider/widgets/rider_bottom_nav_bar.dart';

/// Shared bottom navigation used by Home + Profile (same bar, one shell).
class AppModeBottomNav extends StatelessWidget {
  const AppModeBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    this.isDark = false,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    if (isDark) {
      return DriverBottomNavBar(
        selectedIndex: selectedIndex,
        onTap: onTap,
      );
    }
    return RiderBottomNavBar(
      selectedIndex: selectedIndex,
      onTap: onTap,
    );
  }
}
