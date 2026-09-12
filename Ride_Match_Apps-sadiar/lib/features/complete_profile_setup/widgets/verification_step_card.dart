import 'package:flutter/material.dart';

enum VerificationStepStatus { verify, pending, done }

class VerificationStepCard extends StatelessWidget {
  const VerificationStepCard({
    super.key,
    required this.stepLabel,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.status,
    required this.isDark,
    required this.onTap,
  });

  final String stepLabel;
  final String title;
  final String subtitle;
  final IconData icon;
  final VerificationStepStatus status;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isPending = status == VerificationStepStatus.pending;
    final badgeBg = isPending
        ? (isDark ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6))
        : const Color(0xFFDCFCE7);
    final badgeFg = isPending
        ? (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280))
        : const Color(0xFF166534);
    final iconBg = isPending
        ? (isDark ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6))
        : const Color(0xFFDCFCE7);
    final iconFg = isPending
        ? (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280))
        : const Color(0xFF15803D);

    return Material(
      color: isDark ? const Color(0xFF14171A) : Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDark ? const Color(0xFF262A2E) : const Color(0xFFE5E7EB),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          stepLabel,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                            color: isDark
                                ? const Color(0xFF9CA3AF)
                                : const Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: badgeBg,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            isPending ? 'PENDING' : 'VERIFY',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.4,
                              color: badgeFg,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.35,
                        color: isDark
                            ? const Color(0xFF9CA3AF)
                            : const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconFg, size: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
