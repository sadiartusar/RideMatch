import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onEmojiTap,
    required this.onLocationTap,
    required this.onMicTap,
    this.isDark = false,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onEmojiTap;
  final VoidCallback onLocationTap;
  final VoidCallback onMicTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final fieldBg = isDark ? const Color(0xFF16181B) : Colors.white;
    final border =
        isDark ? const Color(0xFF2C333A) : const Color(0xFFE5E7EB);
    final textColor = isDark ? Colors.white : const Color(0xFF111827);
    final iconColor = const Color(0xFF9CA3AF);

    return ColoredBox(
      color: isDark ? const Color(0xFF0D0F11) : Colors.white,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: fieldBg,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: border),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: onEmojiTap,
                        icon: Icon(
                          Icons.sentiment_satisfied_alt_outlined,
                          color: iconColor,
                          size: 24,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => onSend(),
                          cursorColor: AppColors.button,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Type message...',
                            hintStyle: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 15,
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
                        icon: Icon(
                          Icons.location_on_outlined,
                          color: iconColor,
                          size: 22,
                        ),
                      ),
                      IconButton(
                        onPressed: onMicTap,
                        icon: Icon(
                          Icons.mic_none_rounded,
                          color: iconColor,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: onSend,
                borderRadius: BorderRadius.circular(26),
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: AppColors.button,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 22,
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
