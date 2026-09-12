import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class VibeOptionChip extends StatelessWidget {
  const VibeOptionChip({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    this.expanded = true,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? AppColors.button : const Color(0xFFF6F5F1);
    final fg = selected ? AppColors.buttonForeground : const Color(0xFF111827);

    final child = Material(
      color: bg,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: expanded ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? AppColors.button : const Color(0xFFEAE8E2),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: fg, size: 26),
              const SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: fg,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return expanded ? child : child;
  }
}

class VibePillChip extends StatelessWidget {
  const VibePillChip({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? AppColors.button : const Color(0xFFF6F5F1);
    final fg = selected ? AppColors.buttonForeground : const Color(0xFF111827);

    return Expanded(
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(28),
          child: Container(
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: selected ? AppColors.button : const Color(0xFFEAE8E2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: fg, size: 20),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: fg,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
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

class VibeSectionLabel extends StatelessWidget {
  const VibeSectionLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Color(0xFF111827),
        fontSize: 15,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
