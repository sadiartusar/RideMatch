import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/edit_profile_model.dart';

class EditSocialTrustSection extends StatelessWidget {
  const EditSocialTrustSection({
    super.key,
    required this.links,
    required this.onRemove,
    required this.onLinkChanged,
    required this.onAddMore,
    this.isDark = false,
  });

  final List<SocialTrustLink> links;
  final ValueChanged<int> onRemove;
  final void Function(int index, String value) onLinkChanged;
  final VoidCallback onAddMore;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final sectionBg =
        isDark ? const Color(0xFF14171A) : const Color(0xFFF3F4F6);
    final titleColor = isDark ? Colors.white : const Color(0xFF111827);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: sectionBg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Social Trust',
            style: TextStyle(
              color: titleColor,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < links.length; i++) ...[
            _SocialCard(
              link: links[i],
              isDark: isDark,
              onRemove: () => onRemove(i),
              onChanged: (value) => onLinkChanged(i, value),
            ),
            const SizedBox(height: 10),
          ],
          InkWell(
            onTap: onAddMore,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.border,
                  style: BorderStyle.solid,
                  width: 1.2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline_rounded,
                    size: 18,
                    color: isDark
                        ? const Color(0xFF9CA3AF)
                        : const Color(0xFF6B7280),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Add More Platforms',
                    style: TextStyle(
                      color: isDark
                          ? const Color(0xFF9CA3AF)
                          : const Color(0xFF6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
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

class _SocialCard extends StatelessWidget {
  const _SocialCard({
    required this.link,
    required this.isDark,
    required this.onRemove,
    required this.onChanged,
  });

  final SocialTrustLink link;
  final bool isDark;
  final VoidCallback onRemove;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF16181B) : Colors.white;
    final fieldBg = isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6);
    final titleColor = isDark ? Colors.white : const Color(0xFF111827);
    final muted = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: link.brandColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(link.icon, size: 16, color: link.brandColor),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  link.platform,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              InkWell(
                onTap: onRemove,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: fieldBg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Remove',
                    style: TextStyle(
                      color: muted,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Profile Link',
            style: TextStyle(
              color: muted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            initialValue: link.profileLink,
            onChanged: onChanged,
            style: TextStyle(
              color: titleColor,
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: fieldBg,
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              suffixIcon: link.isVerified
                  ? const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: AppColors.button,
                        size: 20,
                      ),
                    )
                  : null,
              suffixIconConstraints:
                  const BoxConstraints(minWidth: 32, minHeight: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
