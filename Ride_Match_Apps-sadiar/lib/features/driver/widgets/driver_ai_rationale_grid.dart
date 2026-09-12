import 'package:flutter/material.dart';

class DriverAiRationaleGrid extends StatelessWidget {
  const DriverAiRationaleGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(
              Icons.auto_awesome,
              color: Color(0xFF32E116),
              size: 16,
            ),
            SizedBox(width: 6),
            Text(
              'AI Matching Rationale',
              style: TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildRationaleCard(
                icon: Icons.alt_route_rounded,
                title: 'Best match for\nyour route',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildRationaleCard(
                icon: Icons.near_me_outlined,
                title: 'Low pickup\ndistance',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildRationaleCard(
                icon: Icons.payments_outlined,
                title: 'Matches your\nbudget',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildRationaleCard(
                icon: Icons.repeat_rounded,
                title: 'You travel this\nroute frequently',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRationaleCard({
    required IconData icon,
    required String title,
  }) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF16191D),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF262B32),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: const Color(0xFF32E116),
            size: 20,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}
