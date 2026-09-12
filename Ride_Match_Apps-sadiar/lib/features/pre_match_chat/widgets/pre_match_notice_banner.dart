import 'package:flutter/material.dart';

import '../models/pre_match_chat_model.dart';

class PreMatchNoticeBanner extends StatelessWidget {
  const PreMatchNoticeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF8D8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.chat_bubble_outline_rounded,
            color: Color(0xFF3F7A28),
            size: 22,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This is your one-time message',
                  style: TextStyle(
                    color: Color(0xFF14532D),
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Your message will be shown with your ride request. You can send only 1 message before they accept.',
                  style: TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 12.5,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PreMatchMessageBubble extends StatelessWidget {
  const PreMatchMessageBubble({
    super.key,
    required this.message,
  });

  final PreMatchMessage message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF8D8),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message.text,
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 14,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message.timeLabel,
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (message.isDelivered) ...[
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.done_all_rounded,
                      size: 14,
                      color: Color(0xFF22C55E),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
