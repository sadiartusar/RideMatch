import 'package:flutter/material.dart';

class MatchAiRationaleGrid extends StatelessWidget {
  const MatchAiRationaleGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.auto_awesome,
              color: Color(0xFF22C55E),
              size: 16,
            ),
            SizedBox(width: 6),
            Text(
              'AI Matching Rationale',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _RationaleCard(
                icon: Icons.auto_awesome,
                title: 'Best match for\nyour route',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _RationaleCard(
                icon: Icons.near_me_outlined,
                title: 'Low pickup\ndistance',
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _RationaleCard(
                icon: Icons.attach_money_rounded,
                title: 'Matches your\nbudget',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _RationaleCard(
                icon: Icons.schedule_rounded,
                title: 'You travel this\nroute frequently',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RationaleCard extends StatelessWidget {
  const _RationaleCard({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: const Color(0xFF4B5563),
            size: 20,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 13,
              fontWeight: FontWeight.w700,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}
