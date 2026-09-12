import 'package:flutter/material.dart';

class DriverSafetyCard extends StatelessWidget {
  const DriverSafetyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF17191C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDC2626),
          width: 1.2,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.sensors_rounded,
                color: Color(0xFFEF4444),
                size: 22,
              ),
              SizedBox(width: 10),
              Text(
                'Safety First',
                style: TextStyle(
                  color: Color(0xFFEF4444),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Emergency-only recording. Shared with authorities when needed. Deleted after 48 hours.',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 13.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
