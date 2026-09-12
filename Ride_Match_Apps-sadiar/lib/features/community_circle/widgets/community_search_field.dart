import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class CommunitySearchField extends StatelessWidget {
  const CommunitySearchField({
    super.key,
    required this.controller,
    this.isDark = false,
    this.hintText = 'Search friends or circles...',
  });

  final TextEditingController controller;
  final bool isDark;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final fill =
        isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6);
    final hint = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final textColor = isDark ? Colors.white : const Color(0xFF111827);

    return TextField(
      controller: controller,
      style: TextStyle(
        color: textColor,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: hint,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: isDark ? AppColors.button : const Color(0xFF15803D),
          size: 22,
        ),
        filled: true,
        fillColor: fill,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isDark ? AppColors.button : const Color(0xFF15803D),
            width: 1.2,
          ),
        ),
      ),
    );
  }
}
