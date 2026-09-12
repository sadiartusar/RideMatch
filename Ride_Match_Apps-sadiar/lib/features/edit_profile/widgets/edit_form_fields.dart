import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class EditTagSection extends StatelessWidget {
  const EditTagSection({
    super.key,
    required this.title,
    required this.tags,
    required this.addLabel,
    required this.onRemove,
    required this.onAdd,
    this.isDark = false,
  });

  final String title;
  final List<String> tags;
  final String addLabel;
  final ValueChanged<String> onRemove;
  final VoidCallback onAdd;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final titleColor = isDark ? Colors.white : const Color(0xFF111827);
    final chipBg = isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6);
    final chipBorder =
        isDark ? AppColors.darkBorder : AppColors.border;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final tag in tags)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: chipBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: chipBorder),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tag,
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    InkWell(
                      onTap: () => onRemove(tag),
                      child: const Icon(
                        Icons.close_rounded,
                        size: 14,
                        color: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: onAdd,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: chipBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: chipBorder),
            ),
            child: Text(
              addLabel,
              style: TextStyle(
                color: isDark ? AppColors.button : const Color(0xFF15803D),
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EditLabeledField extends StatelessWidget {
  const EditLabeledField({
    super.key,
    required this.label,
    required this.controller,
    this.maxLines = 1,
    this.isDark = false,
  });

  final String label;
  final TextEditingController controller;
  final int maxLines;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final labelColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final fill = isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6);
    final textColor = isDark ? Colors.white : const Color(0xFF111827);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: TextStyle(
            color: textColor,
            fontSize: 14.5,
            fontWeight: FontWeight.w600,
            height: 1.35,
          ),
          cursorColor: AppColors.button,
          decoration: InputDecoration(
            filled: true,
            fillColor: fill,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.button, width: 1.4),
            ),
          ),
        ),
      ],
    );
  }
}
