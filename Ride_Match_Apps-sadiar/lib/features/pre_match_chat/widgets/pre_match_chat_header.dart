import 'package:flutter/material.dart';

class PreMatchChatHeader extends StatelessWidget {
  const PreMatchChatHeader({
    super.key,
    required this.onBack,
    required this.onSafety,
  });

  final VoidCallback onBack;
  final VoidCallback onSafety;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 12, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            visualDensity: VisualDensity.compact,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: Color(0xFF111827),
            ),
          ),
          const Expanded(
            child: Column(
              children: [
                Text(
                  'Pre-Match Chat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Send 1 message before they accept',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onSafety,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFECFDF3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFBBF7D0)),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shield_outlined,
                    color: Color(0xFF16A34A),
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Safety',
                    style: TextStyle(
                      color: Color(0xFF16A34A),
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
