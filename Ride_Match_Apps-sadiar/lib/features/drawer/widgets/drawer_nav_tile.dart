import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/drawer_nav_item.dart';

class DrawerNavTile extends StatelessWidget {
  const DrawerNavTile({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    this.isDark = false,
  });

  final DrawerNavItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final Color foreground = item.isDestructive
        ? AppColors.error
        : (isDark ? Colors.white : AppColors.buttonForeground);

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: isSelected ? AppColors.button : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          splashColor: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.06),
          highlightColor: isDark
              ? Colors.white.withValues(alpha: 0.04)
              : Colors.black.withValues(alpha: 0.03),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Icon(item.icon, size: 22, color: foreground),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    item.label,
                    style: TextStyle(
                      color: foreground,
                      fontSize: 15,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      letterSpacing: -0.1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
