import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class RiderDestinationCard extends StatelessWidget {
  const RiderDestinationCard({
    super.key,
    required this.controller,
    required this.onSetDestination,
  });

  final TextEditingController controller;
  final VoidCallback onSetDestination;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEAE8E2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Where are you going?',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Search your route to find the best match.',
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 13.5,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'DESTINATION',
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          // Search input with green underline
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFF16A34A),
                  width: 2,
                ),
              ),
            ),
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF16A34A),
                  size: 22,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Search your route...',
                      hintStyle: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 4),
                    ),
                    onSubmitted: (_) => onSetDestination(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Set Destination button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onSetDestination,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button,
                foregroundColor: AppColors.buttonForeground,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Set Destination',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
