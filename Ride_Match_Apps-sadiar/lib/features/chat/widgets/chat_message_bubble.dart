import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/chat_models.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    super.key,
    required this.message,
    this.onPlayVoice,
    this.isPlayingVoice = false,
    this.isDark = false,
  });

  final ChatMessageModel message;
  final VoidCallback? onPlayVoice;
  final bool isPlayingVoice;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    if (message.type == ChatMessageType.voice) {
      return _VoiceMessage(
        message: message,
        onPlay: onPlayVoice,
        isPlaying: isPlayingVoice,
        isDark: isDark,
      );
    }
    return _TextMessage(message: message, isDark: isDark);
  }
}

class _TextMessage extends StatelessWidget {
  const _TextMessage({
    required this.message,
    required this.isDark,
  });

  final ChatMessageModel message;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final isMine = message.isMine;
    final bubbleColor = isMine
        ? (isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6))
        : (isDark ? const Color(0xFF16181B) : Colors.white);
    final borderColor = isMine
        ? Colors.transparent
        : (isDark ? const Color(0xFF2C333A) : const Color(0xFFE5E7EB));
    final textColor = isDark ? Colors.white : const Color(0xFF111827);

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        child: Column(
          crossAxisAlignment:
              isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: borderColor),
              ),
              child: Text(
                message.text ?? '',
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  height: 1.35,
                ),
              ),
            ),
            const SizedBox(height: 4),
            _MetaRow(
              timeLabel: message.timeLabel,
              showRead: isMine && message.isRead,
              alignEnd: isMine,
            ),
          ],
        ),
      ),
    );
  }
}

class _VoiceMessage extends StatelessWidget {
  const _VoiceMessage({
    required this.message,
    required this.isDark,
    this.onPlay,
    this.isPlaying = false,
  });

  final ChatMessageModel message;
  final bool isDark;
  final VoidCallback? onPlay;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    final bubbleColor =
        isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6);
    final durationColor =
        isDark ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563);

    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 14, 10),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: onPlay,
                    borderRadius: BorderRadius.circular(22),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: AppColors.button,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: isDark ? Colors.black : Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const _Waveform(),
                  const SizedBox(width: 10),
                  Text(
                    message.voiceDuration ?? '0:00',
                    style: TextStyle(
                      color: durationColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            _MetaRow(
              timeLabel: message.timeLabel,
              showRead: false,
              alignEnd: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _Waveform extends StatelessWidget {
  const _Waveform();

  static const _heights = [
    8.0, 14.0, 10.0, 18.0, 12.0, 20.0, 9.0, 16.0, 11.0, 19.0,
    8.0, 15.0, 10.0, 17.0, 12.0, 8.0, 14.0, 10.0, 18.0, 11.0,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (final h in _heights) ...[
            Container(
              width: 2.5,
              height: h,
              decoration: BoxDecoration(
                color: AppColors.button,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 2.5),
          ],
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({
    required this.timeLabel,
    required this.showRead,
    required this.alignEnd,
  });

  final String timeLabel;
  final bool showRead;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          timeLabel,
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (showRead) ...[
          const SizedBox(width: 4),
          const Icon(
            Icons.done_all_rounded,
            size: 14,
            color: Color(0xFF32E116),
          ),
        ],
      ],
    );
  }
}

class ChatDateSeparator extends StatelessWidget {
  const ChatDateSeparator({
    super.key,
    this.label = 'Today',
    this.isDark = false,
  });

  final String label;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
