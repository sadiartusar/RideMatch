import 'package:flutter/material.dart';

class ChatDetailsTopBar extends StatelessWidget {
  const ChatDetailsTopBar({
    super.key,
    required this.name,
    required this.avatarUrl,
    required this.onBack,
    this.isDark = false,
  });

  final String name;
  final String avatarUrl;
  final VoidCallback onBack;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final barColor =
        isDark ? const Color(0xFF16181B) : const Color(0xFFF7F6F0);
    final titleColor = isDark ? Colors.white : const Color(0xFF111827);

    return Container(
      color: barColor,
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 12),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: titleColor,
              size: 24,
            ),
          ),
          ClipOval(
            child: Image.network(
              avatarUrl,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 40,
                height: 40,
                color: isDark
                    ? const Color(0xFF1B1E23)
                    : const Color(0xFFE5E7EB),
                alignment: Alignment.center,
                child: Icon(
                  Icons.person_rounded,
                  color: isDark
                      ? const Color(0xFF9CA3AF)
                      : const Color(0xFF9CA3AF),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: titleColor,
                fontSize: 17,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
