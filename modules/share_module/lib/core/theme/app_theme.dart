import 'package:flutter/material.dart';
import 'package:share_module/core/constants/app_colors.dart';
import 'package:share_module/core/theme/text_styles.dart';
import 'package:share_module/core/theme/theme_extensions.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),
    textTheme: AppTextStyles.textTheme,
    extensions: const [
      AppSpacingExtension(small: 8, medium: 16, large: 24),
      AppRadiusExtension(small: 4, medium: 8, large: 16),
    ],
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryDark,
      brightness: Brightness.dark,
    ),
    textTheme: AppTextStyles.textThemeDark,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      hintStyle: AppTextStyles.captionNormal(
          color: AppColors.backgroundDark), // hint color
      labelStyle: AppTextStyles.captionNormal(color: AppColors.backgroundDark),
      counterStyle:
          AppTextStyles.captionNormal(color: AppColors.backgroundDark),
    ),
    extensions: const [
      AppSpacingExtension(small: 8, medium: 16, large: 24),
      AppRadiusExtension(small: 4, medium: 8, large: 16),
    ],
  );
}
