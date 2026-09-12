import 'package:flutter/material.dart';

class DriverDocumentRow extends StatelessWidget {
  const DriverDocumentRow({
    super.key,
    required this.label,
    required this.icon,
    required this.isDark,
    required this.isUploaded,
    this.onUpload,
  });

  final String label;
  final IconData icon;
  final bool isDark;
  final bool isUploaded;
  final VoidCallback? onUpload;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF14171A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF262A2E) : const Color(0xFFE5E7EB),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 22,
            color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF374151),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : const Color(0xFF111827),
              ),
            ),
          ),
          if (isUploaded)
            Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Color(0xFF3DF416),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 16, color: Color(0xFF0F172A)),
            )
          else
            GestureDetector(
              onTap: onUpload,
              child: const Text(
                'UPLOAD',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                  color: Color(0xFF3DF416),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
