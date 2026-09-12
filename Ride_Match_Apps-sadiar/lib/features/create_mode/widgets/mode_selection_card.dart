import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/commute_mode_option.dart';

class ModeSelectionCard extends StatelessWidget {
  const ModeSelectionCard({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final CommuteModeOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.button : const Color(0xFFE5E7EB),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      option.icon,
                      color: const Color(0xFF4B5563),
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    option.title,
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    option.subtitle,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...option.features.map(
                    (feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            feature.icon,
                            size: 18,
                            color: const Color(0xFF6B7280),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              feature.label,
                              style: const TextStyle(
                                color: Color(0xFF4B5563),
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (isSelected)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: AppColors.button,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
