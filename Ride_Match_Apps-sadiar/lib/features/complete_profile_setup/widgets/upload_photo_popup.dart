import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Upload photo modal shown when tapping a profile photo slot.
class UploadPhotoPopup extends StatefulWidget {
  const UploadPhotoPopup({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  static Future<bool> show({required bool isDark}) async {
    final result = await Get.dialog<bool>(
      UploadPhotoPopup(isDark: isDark),
      barrierColor: Colors.black.withValues(alpha: 0.45),
      barrierDismissible: true,
    );
    return result == true;
  }

  @override
  State<UploadPhotoPopup> createState() => _UploadPhotoPopupState();
}

class _UploadPhotoPopupState extends State<UploadPhotoPopup> {
  bool _selected = false;

  void _upload() {
    if (!_selected) {
      Get.snackbar('Photo Required', 'Please select or capture a photo first.');
      return;
    }
    Get.back(result: true);
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
          width: MediaQuery.sizeOf(context).width - 48,
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFF3DF416), width: 1.6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Upload photo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'serif',
                  color: titleColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'AVOID FILTERS OR GROUP PHOTOS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                  color: isDark
                      ? const Color(0xFF9CA3AF)
                      : const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 20),
              Material(
                color: isDark ? const Color(0xFF1B1E23) : const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => setState(() => _selected = true),
                  child: CustomPaint(
                    painter: _DashedBorderPainter(
                      color: _selected
                          ? const Color(0xFF3DF416)
                          : (isDark
                              ? const Color(0xFF4B5563)
                              : const Color(0xFF374151)),
                      radius: 16,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 28,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: const BoxDecoration(
                              color: Color(0xFF166534),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add_a_photo_outlined,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            _selected
                                ? 'Photo selected'
                                : 'Select photo or Capture selfie',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF111827),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'JPG, PNG or PDF (max. 2MB)',
                            textAlign: TextAlign.center,
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
                  ),
                ),
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
                          color: Color(0xFF0F172A),
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

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({
    required this.color,
    required this.radius,
  });

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.4
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
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}
