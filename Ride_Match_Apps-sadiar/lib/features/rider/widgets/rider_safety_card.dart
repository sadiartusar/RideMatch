import 'package:flutter/material.dart';

class RiderSafetyCard extends StatelessWidget {
  const RiderSafetyCard({
    super.key,
    this.onLearnMore,
  });

  final VoidCallback? onLearnMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFCA5A5),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Siren Icon + Safety First
          const Row(
            children: [
              Icon(
                Icons.crisis_alert_rounded,
                color: Color(0xFFEF4444),
                size: 22,
              ),
              SizedBox(width: 10),
              Text(
                'Safety First',
                style: TextStyle(
                  color: Color(0xFFEF4444),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Description
          const Text(
            'Emergency recording and real-time tracking are active for all your rides.',
            style: TextStyle(
              color: Color(0xFF991B1B),
              fontSize: 13.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          // Learn more link
          GestureDetector(
            onTap: onLearnMore,
            behavior: HitTestBehavior.opaque,
            child: const Text(
              'Learn more',
              style: TextStyle(
                color: Color(0xFFDC2626),
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFFDC2626),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
