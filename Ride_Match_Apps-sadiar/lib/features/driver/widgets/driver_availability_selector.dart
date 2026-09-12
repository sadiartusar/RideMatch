import 'package:flutter/material.dart';

import '../models/driver_availability_status.dart';

class DriverAvailabilitySelector extends StatelessWidget {
  const DriverAvailabilitySelector({
    super.key,
    required this.currentStatus,
    required this.onStatusChanged,
  });

  final DriverAvailabilityStatus currentStatus;
  final ValueChanged<DriverAvailabilityStatus> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF171A1D),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF262B32),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'AVAILABILITY STATUS',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 16),
          for (final status in DriverAvailabilityStatus.values) ...[
            _StatusCard(
              status: status,
              isSelected: currentStatus == status,
              onTap: () => onStatusChanged(status),
            ),
            if (status != DriverAvailabilityStatus.values.last)
              const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.status,
    required this.isSelected,
    required this.onTap,
  });

  final DriverAvailabilityStatus status;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isAvailable = status == DriverAvailabilityStatus.available;
    final titleColor = isSelected
        ? (isAvailable ? const Color(0xFF32E116) : Colors.white)
        : const Color(0xFFE5E7EB);
    final subtitleColor = isSelected && isAvailable
        ? const Color(0xFF32E116).withValues(alpha: 0.85)
        : const Color(0xFF9CA3AF);
    final iconColor = isSelected && isAvailable
        ? const Color(0xFF32E116)
        : const Color(0xFF9CA3AF);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF121417),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? (isAvailable
                    ? const Color(0xFF1C5B26)
                    : const Color(0xFF4B5563))
                : const Color(0xFF23272E),
            width: isSelected ? 1.4 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(
              status.icon,
              color: iconColor,
              size: 24,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    status.label,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    status.subtitle,
                    style: TextStyle(
                      color: subtitleColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Radio Indicator
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF32E116)
                      : const Color(0xFF6B7280),
                  width: 1.8,
                ),
              ),
              alignment: Alignment.center,
              child: isSelected
                  ? Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF32E116),
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
