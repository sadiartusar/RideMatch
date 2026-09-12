import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class LocationInputCard extends StatelessWidget {
  const LocationInputCard({
    super.key,
    required this.pickupController,
    required this.destinationController,
    required this.onUseCurrentLocation,
  });

  final TextEditingController pickupController;
  final TextEditingController destinationController;
  final VoidCallback onUseCurrentLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'PICKUP LOCATION',
                  style: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.9,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onUseCurrentLocation,
                behavior: HitTestBehavior.opaque,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.gps_fixed_rounded,
                      size: 13,
                      color: Color(0xFF16A34A),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Use current location',
                      style: TextStyle(
                        color: Color(0xFF16A34A),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _LocationField(
            controller: pickupController,
            leading: Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                color: AppColors.button,
                shape: BoxShape.circle,
              ),
            ),
            hint: 'Enter pickup location',
          ),
          const SizedBox(height: 20),
          const Text(
            'DESTINATION',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.9,
            ),
          ),
          const SizedBox(height: 12),
          _LocationField(
            controller: destinationController,
            leading: const Icon(
              Icons.change_history_rounded,
              size: 16,
              color: Color(0xFF111827),
            ),
            hint: 'Where are you going?',
          ),
        ],
      ),
    );
  }
}

class _LocationField extends StatelessWidget {
  const _LocationField({
    required this.controller,
    required this.leading,
    required this.hint,
  });

  final TextEditingController controller;
  final Widget leading;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 20, child: Center(child: leading)),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
              height: 1.25,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
