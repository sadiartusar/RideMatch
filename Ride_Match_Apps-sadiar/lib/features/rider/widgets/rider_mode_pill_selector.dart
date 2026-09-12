import 'package:flutter/material.dart';

import '../../onboarding/models/user_mode.dart';

class RiderModePillSelector extends StatelessWidget {
  const RiderModePillSelector({
    super.key,
    required this.currentMode,
    required this.onSelectMode,
  });

  final UserMode currentMode;
  final ValueChanged<UserMode> onSelectMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFECEAE4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFDFDCD4),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ModeTabItem(
              label: 'Flex',
              isSelected: currentMode == UserMode.flex,
              onTap: () => onSelectMode(UserMode.flex),
            ),
          ),
          Expanded(
            child: _ModeTabItem(
              label: 'Riding',
              isSelected: currentMode == UserMode.rider,
              onTap: () => onSelectMode(UserMode.rider),
            ),
          ),
          Expanded(
            child: _ModeTabItem(
              label: 'Driving',
              isSelected: currentMode == UserMode.driver,
              onTap: () => onSelectMode(UserMode.driver),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeTabItem extends StatelessWidget {
  const _ModeTabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFF15803D) : const Color(0xFF16A34A),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
