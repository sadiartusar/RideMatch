import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class OnboardingJourneyArt extends StatelessWidget {
  const OnboardingJourneyArt({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 310,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(36),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: Stack(
          children: [
            // Custom dashed path across the artboard
            Positioned.fill(
              child: CustomPaint(
                painter: _DashedRoutePainter(),
              ),
            ),

            // Top-left card: Designer Sarah J.
            Positioned(
              top: 24,
              left: 18,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 19,
                      backgroundColor: Color(0xFF1E293B),
                      child: Icon(
                        Icons.person,
                        size: 24,
                        color: Color(0xFFE2E8F0),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'DESIGNER',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                            color: Color(0xFF15803D),
                          ),
                        ),
                        SizedBox(height: 1),
                        Text(
                          'Sarah J.',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF111827),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.splashBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'MATCHING',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF14532D),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Middle badge: Shared Interests: FinTech
            Positioned(
              top: 108,
              right: 42,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF59E0B),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFF59E0B).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Shared Interests:',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'FinTech',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Connecting center node
            Positioned(
              top: 140,
              left: 144,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF14532D), width: 2),
                ),
              ),
            ),

            // Middle badge: Commute Buddy
            Positioned(
              top: 145,
              left: 54,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF14532D),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF14532D).withValues(alpha: 0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Commute',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Buddy',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom-right card: Engineer Marcus T.
            Positioned(
              bottom: 24,
              right: 18,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 19,
                      backgroundColor: Color(0xFF1E293B),
                      child: Icon(
                        Icons.person_outline_rounded,
                        size: 24,
                        color: Color(0xFFE2E8F0),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'ENGINEER',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        SizedBox(height: 1),
                        Text(
                          'Marcus T.',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF111827),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedRoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF14532D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width * 0.10, size.height * 0.72);
    path.cubicTo(
      size.width * 0.35,
      size.height * 0.65,
      size.width * 0.35,
      size.height * 0.40,
      size.width * 0.50,
      size.height * 0.45,
    );
    path.cubicTo(
      size.width * 0.65,
      size.height * 0.50,
      size.width * 0.68,
      size.height * 0.28,
      size.width * 0.90,
      size.height * 0.22,
    );

    // Draw dashed line
    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      double distance = 0;
      const dashLength = 8.0;
      const dashSpace = 6.0;

      while (distance < metric.length) {
        final end = (distance + dashLength < metric.length)
            ? distance + dashLength
            : metric.length;
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance += dashLength + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
