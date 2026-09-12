import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Identity Verification modal — front/back government ID upload.
class IdentityVerificationPopup extends StatefulWidget {
  const IdentityVerificationPopup({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  static Future<void> show({required bool isDark}) {
    return Get.dialog(
      IdentityVerificationPopup(isDark: isDark),
      barrierColor: Colors.black.withValues(alpha: 0.45),
      barrierDismissible: true,
    );
  }

  @override
  State<IdentityVerificationPopup> createState() =>
      _IdentityVerificationPopupState();
}

class _IdentityVerificationPopupState extends State<IdentityVerificationPopup> {
  bool _frontSelected = false;
  bool _backSelected = false;

  void _upload() {
    if (!_frontSelected || !_backSelected) {
      Get.snackbar(
        'ID Required',
        'Please add both front and back of your ID card.',
      );
      return;
    }
    Get.back();
    Get.snackbar('Uploaded', 'Identity documents submitted for review.');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final cardBg = isDark ? const Color(0xFF14171A) : Colors.white;
    final titleColor = isDark ? Colors.white : const Color(0xFF111827);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.sizeOf(context).width - 40,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFF3DF416), width: 1.6),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Identity Verification',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'serif',
                  letterSpacing: -0.3,
                  color: titleColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'OFFICIAL GOVERNMENT ID',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                  color: isDark
                      ? const Color(0xFF9CA3AF)
                      : const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 20),
              _IdUploadSlot(
                isDark: isDark,
                label: 'Front side of your ID Card',
                selected: _frontSelected,
                onTap: () => setState(() => _frontSelected = true),
              ),
              const SizedBox(height: 12),
              _IdUploadSlot(
                isDark: isDark,
                label: 'Back side of your ID Card',
                selected: _backSelected,
                onTap: () => setState(() => _backSelected = true),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Material(
                  color: const Color(0xFF3DF416),
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: _upload,
                    child: const Center(
                      child: Text(
                        'UPLOAD',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IdUploadSlot extends StatelessWidget {
  const _IdUploadSlot({
    required this.isDark,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final bool isDark;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = selected
        ? const Color(0xFF3DF416)
        : (isDark ? const Color(0xFF4B5563) : const Color(0xFF374151));
    final fill = isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6);

    return Material(
      color: fill,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: CustomPaint(
          painter: _DashedBorderPainter(
            color: borderColor,
            radius: 16,
            strokeWidth: 1.4,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFF166534),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selected ? 'Selected · $label' : label,
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w800,
                          color: isDark ? Colors.white : const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'JPG, PNG or PDF (max. 2MB)',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? const Color(0xFF9CA3AF)
                              : const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({
    required this.color,
    required this.radius,
    required this.strokeWidth,
  });

  final Color color;
  final double radius;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          Radius.circular(radius),
        ),
      );

    const dashWidth = 6.0;
    const dashSpace = 4.0;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.radius != radius ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
