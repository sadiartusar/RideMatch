import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class PreMatchQuickReplies extends StatelessWidget {
  const PreMatchQuickReplies({
    super.key,
    required this.replies,
    required this.onSelect,
  });

  final List<String> replies;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: replies.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final reply = replies[index];
          return GestureDetector(
            onTap: () => onSelect(reply),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Text(
                reply,
                style: const TextStyle(
                  color: Color(0xFF4B5563),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PreMatchInputBar extends StatelessWidget {
  const PreMatchInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onEmojiTap,
    required this.onLocationTap,
    required this.onMicTap,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onEmojiTap;
  final VoidCallback onLocationTap;
  final VoidCallback onMicTap;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF7F8FA),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF0F3),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: onEmojiTap,
                        icon: const Icon(
                          Icons.sentiment_satisfied_alt_outlined,
                          color: Color(0xFF9CA3AF),
                          size: 22,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => onSend(),
                          cursorColor: AppColors.button,
                          style: const TextStyle(
                            color: Color(0xFF111827),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Type message...',
                            hintStyle: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: onLocationTap,
                        icon: const Icon(
                          Icons.location_on_outlined,
                          color: Color(0xFF9CA3AF),
                          size: 20,
                        ),
                      ),
                      IconButton(
                        onPressed: onMicTap,
                        icon: const Icon(
                          Icons.mic_none_rounded,
                          color: Color(0xFF9CA3AF),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: onSend,
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: AppColors.button,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.send_rounded,
                    color: Color(0xFF111827),
                    size: 20,
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
