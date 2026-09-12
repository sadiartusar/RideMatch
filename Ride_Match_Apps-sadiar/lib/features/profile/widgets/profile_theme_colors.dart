import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ProfileThemeColors {
  const ProfileThemeColors({required this.isDark});

  final bool isDark;

  Color get scaffold =>
      isDark ? const Color(0xFF0D0F11) : Colors.white;

  Color get card =>
      isDark ? const Color(0xFF16181B) : Colors.white;

  Color get cardMuted =>
      isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6);

  Color get border =>
      isDark ? AppColors.darkBorder : AppColors.border;

  Color get title =>
      isDark ? Colors.white : const Color(0xFF111827);

  Color get body =>
      isDark ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563);

  Color get label =>
      isDark ? const Color(0xFF9CA3AF) : const Color(0xFF9CA3AF);

  Color get iconBg =>
      isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6);

  Color get icon =>
      isDark ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563);

  Color get secondaryButton =>
      isDark ? const Color(0xFF1B1E23) : const Color(0xFFE5E7EB);

  Color get walletGlow =>
      isDark ? const Color(0xFF132918) : const Color(0xFFECFDF3);

  Color get navBar =>
      isDark ? const Color(0xFF0B0D0F) : Colors.white;
}
