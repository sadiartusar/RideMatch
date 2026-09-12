import 'package:flutter/material.dart';

import '../../chat/models/chat_models.dart';

class DriverChatBubble extends StatelessWidget {
  const DriverChatBubble({
    super.key,
    required this.message,
    required this.isPlayingVoice,
    required this.onPlayVoice,
  });

  final ChatMessageModel message;
  final bool isPlayingVoice;
  final VoidCallback onPlayVoice;

  @override
  Widget build(BuildContext context) {
    const greenAccent = Color(0xFF32E116);
    final isMine = message.isMine;

    if (message.type == ChatMessageType.voice) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2228),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
              bottomLeft: Radius.circular(4),
            ),
            border: Border.all(color: const Color(0xFF2B313A)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Play / Pause Circle
                  GestureDetector(
                    onTap: onPlayVoice,
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(
                        color: greenAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isPlayingVoice
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Waveform bars
                  _buildWaveform(isPlayingVoice, greenAccent),
                  const SizedBox(width: 12),

                  // Duration
                  Text(
                    message.voiceDuration ?? '0:45',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message.timeLabel,
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    // Text Bubble
    final bubbleBg =
        isMine ? const Color(0xFF22272E) : const Color(0xFF1E2228);
    final borderCol =
        isMine ? const Color(0xFF2D3540) : const Color(0xFF2B313A);

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.76,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bubbleBg,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMine ? 16 : 4),
            bottomRight: Radius.circular(isMine ? 4 : 16),
          ),
          border: Border.all(color: borderCol),
        ),
        child: Column(
          crossAxisAlignment:
              isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.text ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.35,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.timeLabel,
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  isMine ? Icons.done_all_rounded : Icons.done_rounded,
                  color: greenAccent,
                  size: 13,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaveform(bool isPlaying, Color activeColor) {
    const barHeights = [
      8.0, 14.0, 20.0, 12.0, 18.0, 24.0, 16.0, 22.0, 10.0,
      26.0, 18.0, 14.0, 22.0, 16.0, 20.0, 12.0, 18.0, 10.0
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(barHeights.length, (i) {
        final height = barHeights[i];
        final isPlayed = i < (isPlaying ? 12 : 7);
        return Container(
          width: 3,
          height: height,
          margin: const EdgeInsets.symmetric(horizontal: 1.5),
          decoration: BoxDecoration(
            color: isPlayed ? activeColor : const Color(0xFF4B5563),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
