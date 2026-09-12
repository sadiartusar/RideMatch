import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class DriverRouteCard extends StatelessWidget {
  const DriverRouteCard({
    super.key,
    required this.controller,
    required this.onSetRoute,
  });

  final TextEditingController controller;
  final VoidCallback onSetRoute;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
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
            'Set your route to find nearby riders',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 16),
          // Route Input Field
          Container(
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFF121417),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFF2A2F37),
                width: 1,
              ),
            ),
            child: TextField(
              controller: controller,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              cursorColor: const Color(0xFF32E116),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Transform.rotate(
                    angle: math.pi / 4,
                    child: const Icon(
                      Icons.navigation_outlined,
                      color: Color(0xFF32E116),
                      size: 20,
                    ),
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 46,
                  minHeight: 20,
                ),
                hintText: 'Set driving route...',
                hintStyle: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // "Set Route" Bright Green Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: onSetRoute,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button,
                foregroundColor: AppColors.buttonForeground,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Set Route',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
