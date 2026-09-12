import 'package:flutter/material.dart';

class DriverFilterMapPreview extends StatelessWidget {
  const DriverFilterMapPreview({
    super.key,
    required this.radiusKm,
  });

  final double radiusKm;

  @override
  Widget build(BuildContext context) {
    // Map radius to circle size (between 40 and 120)
    final circleSize = 35.0 + (radiusKm / 20.0) * 85.0;

    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: const Color(0xFF1E2125),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF2C333A),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Custom map grid background lines
            CustomPaint(
              size: const Size(double.infinity, 140),
              painter: _MapGridPainter(),
            ),
            // Radar outer circle
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: circleSize,
              height: circleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF32E116).withValues(alpha: 0.18),
                border: Border.all(
                  color: const Color(0xFF32E116),
                  width: 1.5,
                ),
              ),
            ),
            // Center pin dot
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF32E116),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = const Color(0xFF23272D);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    final roadPaint = Paint()
      ..color = const Color(0xFF2D323A)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    final thinRoadPaint = Paint()
      ..color = const Color(0xFF272C33)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Diagonal road
    final path1 = Path()
      ..moveTo(0, size.height * 0.8)
      ..lineTo(size.width, size.height * 0.2);
    canvas.drawPath(path1, roadPaint);

    // Cross roads
    final path2 = Path()
      ..moveTo(size.width * 0.2, 0)
      ..lineTo(size.width * 0.8, size.height);
    canvas.drawPath(path2, roadPaint);

    // Grid lines
    for (double i = 0; i < size.width; i += 32) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), thinRoadPaint);
    }
    for (double j = 0; j < size.height; j += 32) {
      canvas.drawLine(Offset(0, j), Offset(size.width, j), thinRoadPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
