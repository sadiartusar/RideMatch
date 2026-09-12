import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/chat_models.dart';

class ChatThreadTile extends StatelessWidget {
  const ChatThreadTile({
    super.key,
    required this.thread,
    required this.onTap,
    this.isDark = false,
  });

  final ChatThreadModel thread;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final nameColor = isDark ? Colors.white : const Color(0xFF111827);
    final previewColor =
        isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final timeColor =
        isDark ? const Color(0xFF9CA3AF) : const Color(0xFF9CA3AF);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Avatar(
              url: thread.avatarUrl,
              isOnline: thread.isOnline,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          thread.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: nameColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        thread.timeLabel,
                        style: TextStyle(
                          color: timeColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                  if (thread.isVerified) ...[
                    const SizedBox(height: 4),
                    const Row(
                      children: [
                        Icon(
                          Icons.verified_rounded,
                          size: 14,
                          color: Color(0xFF16A34A),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Verified',
                          style: TextStyle(
                            color: Color(0xFF16A34A),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 4),
                  Text(
                    thread.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: previewColor,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.url,
    required this.isOnline,
  });

  final String url;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 52,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipOval(
            child: Image.network(
              url,
              width: 52,
              height: 52,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 52,
                height: 52,
                color: const Color(0xFFE5E7EB),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.person_rounded,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            ),
          ),
          if (isOnline)
            Positioned(
              right: 1,
              bottom: 1,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: AppColors.button,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
