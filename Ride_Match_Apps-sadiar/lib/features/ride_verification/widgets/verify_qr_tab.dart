import 'package:flutter/material.dart';

class VerifyQrTab extends StatelessWidget {
  const VerifyQrTab({
    super.key,
    required this.qrPayload,
    required this.onScanQr,
    this.isDark = true,
  });

  final String qrPayload;
  final VoidCallback onScanQr;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF16191D) : Colors.white;
    final borderCol = isDark ? const Color(0xFF262B32) : const Color(0xFFE5E7EB);
    const greenAccent = Color(0xFF32E116);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'VERIFICATION QR',
          style: TextStyle(
            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 14),

        // QR Code Card
        Container(
          width: 210,
          height: 210,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CustomPaint(
            painter: _QrPatternPainter(),
          ),
        ),
        const SizedBox(height: 14),

        Text(
          'Ask the rider to scan this QR code to confirm\nride completion.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
            fontSize: 11.5,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 18),

        // Scan Rider QR Code Button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            onPressed: onScanQr,
            icon: const Icon(
              Icons.qr_code_scanner_rounded,
              color: greenAccent,
              size: 20,
            ),
            label: const Text(
              'Scan Rider QR Code',
              style: TextStyle(
                color: greenAccent,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: greenAccent.withValues(alpha: 0.08),
              side: BorderSide(
                color: greenAccent.withValues(alpha: 0.4),
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),

        // Trust & Safety Disclaimer Card
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderCol),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.shield_outlined,
                color: Color(0xFFEAB308),
                size: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TRUST & SAFETY',
                      style: TextStyle(
                        color: Color(0xFFEAB308),
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Instant cryptographic validation confirms safe ride completion.',
                      style: TextStyle(
                        color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                        fontSize: 11,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QrPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF111827)
      ..style = PaintingStyle.fill;

    // Corner Finder Patterns (Top-Left, Top-Right, Bottom-Left)
    _drawFinderPattern(canvas, 0, 0, 48, paint);
    _drawFinderPattern(canvas, size.width - 48, 0, 48, paint);
    _drawFinderPattern(canvas, 0, size.height - 48, 48, paint);

    // Decorative QR data modules
    const step = 9.0;
    for (double x = 12; x < size.width - 12; x += step) {
      for (double y = 12; y < size.height - 12; y += step) {
        // Skip corner finder zones
        if ((x < 56 && y < 56) ||
            (x > size.width - 56 && y < 56) ||
            (x < 56 && y > size.height - 56)) {
          continue;
        }
        final hash = (x * 13 + y * 29).toInt() % 7;
        if (hash == 0 || hash == 2 || hash == 5) {
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(x, y, step - 2.5, step - 2.5),
              const Radius.circular(1.5),
            ),
            paint,
          );
        }
      }
    }
  }

  void _drawFinderPattern(
    Canvas canvas,
    double x,
    double y,
    double size,
    Paint paint,
  ) {
    // Outer square
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, size, size),
        const Radius.circular(8),
      ),
      paint,
    );
    // Inner white cutout
    final whitePaint = Paint()..color = Colors.white;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x + 7, y + 7, size - 14, size - 14),
        const Radius.circular(5),
      ),
      whitePaint,
    );
    // Center black dot
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x + 14, y + 14, size - 28, size - 28),
        const Radius.circular(3),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
