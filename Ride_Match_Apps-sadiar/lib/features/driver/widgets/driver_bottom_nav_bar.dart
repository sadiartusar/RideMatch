import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';

class DriverBottomNavBar extends StatelessWidget {
  const DriverBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0B0D0F),
        border: Border(
          top: BorderSide(
            color: Color(0xFF1A1D21),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: _NavItem(
                  index: 0,
                  selectedIndex: selectedIndex,
                  label: 'Home',
                  assetPath: AppAssets.navHome,
                  onTap: () => onTap(0),
                ),
              ),
              Expanded(
                child: _NavItem(
                  index: 1,
                  selectedIndex: selectedIndex,
                  label: 'Route',
                  assetPath: AppAssets.navRoute,
                  onTap: () => onTap(1),
                ),
              ),
              Expanded(
                child: _NavItem(
                  index: 2,
                  selectedIndex: selectedIndex,
                  label: 'Chat',
                  assetPath: AppAssets.navChat,
                  onTap: () => onTap(2),
                ),
              ),
              Expanded(
                child: _NavItem(
                  index: 3,
                  selectedIndex: selectedIndex,
                  label: 'Wallet',
                  assetPath: AppAssets.navWallet,
                  onTap: () => onTap(3),
                ),
              ),
              Expanded(
                child: _NavItem(
                  index: 4,
                  selectedIndex: selectedIndex,
                  label: 'Profile',
                  assetPath: AppAssets.navProfile,
                  onTap: () => onTap(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.index,
    required this.selectedIndex,
    required this.label,
    required this.assetPath,
    required this.onTap,
  });

  final int index;
  final int selectedIndex;
  final String label;
  final String assetPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;

    if (isSelected) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF32E116),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                assetPath,
                width: 20,
                height: 20,
                color: Colors.black,
                colorBlendMode: BlendMode.srcIn,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.circle,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              assetPath,
              width: 22,
              height: 22,
              color: Colors.white,
              colorBlendMode: BlendMode.srcIn,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.circle,
                size: 22,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
