import 'package:flutter/material.dart';

class DriverTripTypeSelector extends StatelessWidget {
  const DriverTripTypeSelector({
    super.key,
    required this.isOneWay,
    required this.onChanged,
  });

  final bool isOneWay;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF171A1D),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF262B32),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: isOneWay
                      ? const Color(0xFF32E116)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Text(
                  'One-way',
                  style: TextStyle(
                    color: isOneWay
                        ? const Color(0xFF0B0D0F)
                        : const Color(0xFF9CA3AF),
                    fontSize: 14,
                    fontWeight: isOneWay ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: !isOneWay
                      ? const Color(0xFF32E116)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Round Trip',
                  style: TextStyle(
                    color: !isOneWay
                        ? const Color(0xFF0B0D0F)
                        : const Color(0xFF9CA3AF),
                    fontSize: 14,
                    fontWeight: !isOneWay ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
