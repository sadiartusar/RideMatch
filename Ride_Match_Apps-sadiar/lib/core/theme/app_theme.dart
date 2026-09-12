import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimensions.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(
    brightness: Brightness.light,
    background: AppColors.background,
    surface: AppColors.surface,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
    border: AppColors.border,
  );

  static ThemeData get dark => _build(
    brightness: Brightness.dark,
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    textPrimary: AppColors.darkTextPrimary,
    textSecondary: AppColors.darkTextSecondary,
    border: AppColors.darkBorder,
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color textPrimary,
    required Color textSecondary,
    required Color border,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: surface,
      error: AppColors.error,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.titleMedium.copyWith(color: textPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.button,
          foregroundColor: AppColors.buttonForeground,
          minimumSize: const Size.fromHeight(AppDimensions.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          textStyle: AppTextStyles.button,
          elevation: 0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingMd,
          vertical: AppDimensions.spacingMd,
        ),
        border: _outline(border),
        enabledBorder: _outline(border),
        focusedBorder: _outline(AppColors.primary, width: 1.5),
        errorBorder: _outline(AppColors.error),
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: textSecondary),
      ),
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.headlineLarge.copyWith(color: textPrimary),
        headlineMedium: AppTextStyles.headlineMedium.copyWith(
          color: textPrimary,
        ),
        titleMedium: AppTextStyles.titleMedium.copyWith(color: textPrimary),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: textPrimary),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(color: textSecondary),
        labelLarge: AppTextStyles.labelLarge,
      ),
    );
  }

  static OutlineInputBorder _outline(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
