import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/notification_item_model.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.item,
    required this.onTap,
    this.isDark = false,
  });

  final NotificationItemModel item;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final bool emphasized = item.isUnread;

    final Color cardColor = isDark
        ? (emphasized ? const Color(0xFF1B1E23) : const Color(0xFF14171A))
        : (emphasized ? Colors.white : const Color(0xFFF3F4F6));

    final Color? borderColor = emphasized
        ? (isDark ? const Color(0xFF2C333A) : AppColors.border)
        : null;

    final Color titleColor =
        isDark ? Colors.white : const Color(0xFF111827);
    final Color bodyColor =
        isDark ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563);
    final Color timeColor = const Color(0xFF9CA3AF);

    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        splashColor: isDark
            ? Colors.white.withValues(alpha: 0.06)
            : Colors.black.withValues(alpha: 0.04),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: borderColor != null
                ? Border.all(color: borderColor, width: 1)
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      item.title,
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    item.timeLabel,
                    style: TextStyle(
                      color: timeColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                item.body,
                style: TextStyle(
                  color: bodyColor,
                  fontSize: 13.5,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
