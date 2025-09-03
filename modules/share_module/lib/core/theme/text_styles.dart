import 'package:flutter/material.dart';
import 'package:share_module/core/constants/app_colors.dart';

class AppTextStyles {
  static Color color = AppColors.primaryBlack;

  static TextStyle titleBold({color}) {
    return TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w800,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle title({color}) {
    return TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle headingExtraBold({color}) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle headingBold({color}) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle headingMedium({color}) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle headingNormal({color}) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.normal,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle subHeadingSubTitleExtraBold({color}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w800,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle subHeadingSubTitleBold({color}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle subHeadingSubTitleMedium({color}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle subHeadingSubTitleNormal({color}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle bodyExtraBold({color}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w800,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle bodyBold({color}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle bodyMedium({color}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle bodyNormal({color}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle bodyRegularExtraBold({color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w800,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle bodyRegularBold({color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w800,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle bodyRegularMedium({color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle bodyRegularNormal({color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle captionExtraBold({color}) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w800,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle captionBold({color}) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle captionMedium({color}) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle captionNormal({color}) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextStyle labelNormal({color}) {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      height: 1.5,
      color: color ?? AppColors.primaryBlack,
    );
  }

  static TextTheme get textTheme => const TextTheme(
      // headlineLarge: headingNormal,
      // bodyMedium: bodyMedium,
      // bodySmall: captionNormal,
      );

  static TextTheme get textThemeDark => textTheme.copyWith(
        bodySmall: captionNormal(color: Colors.white),
        headlineLarge: captionNormal(color: Colors.white),
        bodyMedium: captionNormal(color: Colors.white),
      );
}
