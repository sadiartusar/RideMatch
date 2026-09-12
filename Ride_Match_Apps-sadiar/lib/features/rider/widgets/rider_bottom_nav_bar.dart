import 'package:flutter/material.dart';

class RiderBottomNavBar extends StatelessWidget {
  const RiderBottomNavBar({
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
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE5E7EB),
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
                  icon: Icons.home_rounded,
                  onTap: () => onTap(0),
                ),
              ),
              Expanded(
                child: _NavItem(
                  index: 1,
                  selectedIndex: selectedIndex,
                  label: 'Find',
                  icon: Icons.search_rounded,
                  onTap: () => onTap(1),
                ),
              ),
              Expanded(
                child: _NavItem(
                  index: 2,
                  selectedIndex: selectedIndex,
                  label: 'Chat',
                  icon: Icons.chat_bubble_outline_rounded,
                  onTap: () => onTap(2),
                ),
              ),
              Expanded(
                child: _NavItem(
                  index: 3,
                  selectedIndex: selectedIndex,
                  label: 'Wallet',
                  icon: Icons.account_balance_wallet_outlined,
                  onTap: () => onTap(3),
                ),
              ),
              Expanded(
                child: _NavItem(
                  index: 4,
                  selectedIndex: selectedIndex,
                  label: 'Profile',
                  icon: Icons.person_outline_rounded,
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
    required this.icon,
    required this.onTap,
  });

  final int index;
  final int selectedIndex;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;

    if (isSelected) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFD4F8D3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 22,
                color: const Color(0xFF111827),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF111827),
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
            Icon(
              icon,
              size: 22,
              color: const Color(0xFF4B5563),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF4B5563),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
