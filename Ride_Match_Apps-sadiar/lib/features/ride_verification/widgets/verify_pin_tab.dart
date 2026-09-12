import 'package:flutter/material.dart';

class VerifyPinTab extends StatelessWidget {
  const VerifyPinTab({
    super.key,
    required this.pinCode,
    required this.pinController,
    required this.onSwitchToQr,
    required this.onMicTap,
    this.isDark = true,
  });

  final String pinCode;
  final TextEditingController pinController;
  final VoidCallback onSwitchToQr;
  final VoidCallback onMicTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : const Color(0xFF111827);
    final cardBg = isDark ? const Color(0xFF16191D) : Colors.white;
    final borderCol = isDark ? const Color(0xFF262B32) : const Color(0xFFE5E7EB);
    const greenAccent = Color(0xFF32E116);

    final pinDigits = pinCode.padRight(4, '0').split('');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Generated PIN Display Box
        Center(
          child: Column(
            children: [
              Text(
                'YOUR RIDE PIN',
                style: TextStyle(
                  color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final digit in pinDigits) ...[
                    Container(
                      width: 52,
                      height: 56,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: borderCol, width: 1.5),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        digit,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Ask rider to enter this PIN',
                style: TextStyle(
                  color: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // 2. Or Enter Rider PIN Input
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderCol),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enter Rider PIN',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    onPressed: onMicTap,
                    icon: Icon(
                      Icons.mic_none_rounded,
                      color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                      size: 20,
                    ),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: pinController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 14,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  hintText: '• • • •',
                  hintStyle: TextStyle(
                    color: isDark ? const Color(0xFF4B5563) : const Color(0xFF9CA3AF),
                    fontSize: 20,
                    letterSpacing: 14,
                  ),
                  filled: true,
                  fillColor: isDark ? const Color(0xFF0F1114) : const Color(0xFFF9FAFB),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: borderCol),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: borderCol),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: greenAccent, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 3. Scan QR Code Alternative Button
        InkWell(
          onTap: onSwitchToQr,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: borderCol),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.qr_code_scanner_rounded,
                  color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563),
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Scan QR code',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Quick verification via app',
                        style: TextStyle(
                          color: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
                  size: 14,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),

        // 4. Trust & Safety Disclaimer Card
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF14171A) : const Color(0xFFF3F4F6),
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
                      'Confirmation is required from both parties before the escrow releases.',
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
