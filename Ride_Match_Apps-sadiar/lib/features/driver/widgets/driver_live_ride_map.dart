import 'package:flutter/material.dart';

class DriverLiveRideMap extends StatelessWidget {
  const DriverLiveRideMap({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        // Coordinates tailored so that the full route and all pins
        // sit comfortably in the upper 48% of the screen
        final originOffset = Offset(w * 0.22, h * 0.36);
        final turn1Offset = Offset(w * 0.35, h * 0.28);
        final carOffset = Offset(w * 0.38, h * 0.21);
        final turn2Offset = Offset(w * 0.40, h * 0.16);
        final turn3Offset = Offset(w * 0.43, h * 0.08);
        final destOffset = Offset(w * 0.52, h * 0.07);

        return SizedBox(
          width: w,
          height: h,
          child: Stack(
            children: [
              // 1. Base Map Canvas (Roads, Water, Polyline, Neighborhoods)
              Positioned.fill(
                child: CustomPaint(
                  painter: _LiveRouteMapPainter(
                    origin: originOffset,
                    turn1: turn1Offset,
                    car: carOffset,
                    turn2: turn2Offset,
                    turn3: turn3Offset,
                    destination: destOffset,
                  ),
                ),
              ),

              // 2. Origin Marker: SF MOMA (Card + Blue Dot)
              Positioned(
                left: originOffset.dx - 10,
                top: originOffset.dy - 65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.18),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.museum_outlined,
                            size: 13,
                            color: Color(0xFF2563EB),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'San Francisco\nModern Art Museum',
                            style: TextStyle(
                              color: Color(0xFF1F2937),
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              height: 1.15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6)
                              .withValues(alpha: 0.25),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2563EB),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 3. Car Icon moving along route
              Positioned(
                left: carOffset.dx - 16,
                top: carOffset.dy - 16,
                child: Transform.rotate(
                  angle: -0.15,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.35),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.directions_car_filled_rounded,
                        color: Color(0xFF1F2937),
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),

              // 4. Destination Marker: Chinatown Pin
              Positioned(
                left: destOffset.dx - 28,
                top: destOffset.dy - 40,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color(0xFFEF4444),
                      size: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Text(
                        'Chinatown',
                        style: TextStyle(
                          color: Color(0xFF1F2937),
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LiveRouteMapPainter extends CustomPainter {
  _LiveRouteMapPainter({
    required this.origin,
    required this.turn1,
    required this.car,
    required this.turn2,
    required this.turn3,
    required this.destination,
  });

  final Offset origin;
  final Offset turn1;
  final Offset car;
  final Offset turn2;
  final Offset turn3;
  final Offset destination;

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Map Base
    final bgPaint = Paint()..color = const Color(0xFFEEF2F5);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // 2. Water Bay on Right / Top-Right
    final waterPaint = Paint()..color = const Color(0xFFC7E2FA);
    final waterPath = Path()
      ..moveTo(size.width * 0.55, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.45)
      ..quadraticBezierTo(
        size.width * 0.82,
        size.height * 0.35,
        size.width * 0.68,
        size.height * 0.18,
      )
      ..quadraticBezierTo(
        size.width * 0.60,
        size.height * 0.08,
        size.width * 0.55,
        0,
      )
      ..close();
    canvas.drawPath(waterPath, waterPaint);

    // Piers on water
    final pierPaint = Paint()
      ..color = const Color(0xFFD6E8F7)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < 4; i++) {
      final y = size.height * 0.08 + (i * 18);
      canvas.drawLine(
        Offset(size.width * 0.72 + (i * 8), y),
        Offset(size.width * 0.80 + (i * 8), y - 10),
        pierPaint,
      );
    }

    // 3. Grid Streets (Diagonal SF street grid)
    final gridPaint = Paint()
      ..color = const Color(0xFFD9E1E7)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (double x = -100; x < size.width + 200; x += 32) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x - size.height * 0.3, size.height),
        gridPaint,
      );
    }
    for (double y = 0; y < size.height; y += 32) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y - size.width * 0.25),
        gridPaint,
      );
    }

    // Major Arteries (White streets)
    final avenuePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    // Market Street
    final marketPath = Path()
      ..moveTo(0, size.height * 0.42)
      ..lineTo(size.width * 0.7, size.height * 0.22);
    canvas.drawPath(marketPath, avenuePaint);

    // Columbus Avenue
    final columbusPath = Path()
      ..moveTo(size.width * 0.34, size.height * 0.35)
      ..lineTo(size.width * 0.46, 0);
    canvas.drawPath(columbusPath, avenuePaint);

    // 4. Parks / Greenery
    final parkPaint = Paint()..color = const Color(0xFFD3EAD7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.28, size.height * 0.18, 28, 22),
        const Radius.circular(4),
      ),
      parkPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.14, size.height * 0.12, 34, 26),
        const Radius.circular(4),
      ),
      parkPaint,
    );

    // 5. Neighborhood Text Labels
    _drawLabel(canvas, 'RUSSIAN\nHILL', Offset(size.width * 0.28, size.height * 0.08));
    _drawLabel(canvas, 'NORTH\nBEACH', Offset(size.width * 0.48, size.height * 0.11));
    _drawLabel(canvas, 'NOB HILL', Offset(size.width * 0.28, size.height * 0.16));
    _drawLabel(canvas, 'FINANCIAL\nDISTRICT', Offset(size.width * 0.42, size.height * 0.21));
    _drawLabel(canvas, 'SOMA', Offset(size.width * 0.38, size.height * 0.37));

    // 6. Polyline Route (Glowing Green Line)
    final glowPaint = Paint()
      ..color = const Color(0xFF32E116).withValues(alpha: 0.35)
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final routePaint = Paint()
      ..color = const Color(0xFF32E116)
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final routePath = Path()
      ..moveTo(origin.dx, origin.dy)
      ..lineTo(origin.dx + 18, origin.dy - 35)
      ..lineTo(turn1.dx, turn1.dy)
      ..lineTo(car.dx, car.dy)
      ..lineTo(turn2.dx, turn2.dy)
      ..lineTo(turn3.dx, turn3.dy)
      ..lineTo(destination.dx, destination.dy);

    canvas.drawPath(routePath, glowPaint);
    canvas.drawPath(routePath, routePaint);
  }

  void _drawLabel(Canvas canvas, String text, Offset offset) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Color(0xFF94A3B8),
          fontSize: 8.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
          height: 1.1,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
