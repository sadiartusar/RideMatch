import 'package:flutter/material.dart';

class ChatSearchField extends StatelessWidget {
  const ChatSearchField({
    super.key,
    required this.controller,
    this.isDark = false,
  });

  final TextEditingController controller;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final fill = isDark ? const Color(0xFF16181B) : Colors.white;
    final border =
        isDark ? const Color(0xFF2C333A) : const Color(0xFFE5E7EB);
    final hint = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF9CA3AF);
    final icon = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

    return TextField(
      controller: controller,
      style: TextStyle(
        color: isDark ? Colors.white : const Color(0xFF111827),
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: 'Search active riders...',
        hintStyle: TextStyle(
          color: hint,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: icon,
          size: 22,
        ),
        filled: true,
        fillColor: fill,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: border, width: 1.4),
        ),
      ),
    );
  }
}
