import 'dart:ui';

import 'package:flutter/material.dart';

/// Example: Custom spacing values stored in the theme
class AppSpacingExtension extends ThemeExtension<AppSpacingExtension> {
  final double small;
  final double medium;
  final double large;

  const AppSpacingExtension({
    required this.small,
    required this.medium,
    required this.large,
  });

  @override
  AppSpacingExtension copyWith({
    double? small,
    double? medium,
    double? large,
  }) {
    return AppSpacingExtension(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
    );
  }

  @override
  AppSpacingExtension lerp(
      ThemeExtension<AppSpacingExtension>? other, double t) {
    if (other is! AppSpacingExtension) return this;
    return AppSpacingExtension(
      small: lerpDouble(small, other.small, t)!,
      medium: lerpDouble(medium, other.medium, t)!,
      large: lerpDouble(large, other.large, t)!,
    );
  }
}

/// Example: Custom border radius values
class AppRadiusExtension extends ThemeExtension<AppRadiusExtension> {
  final double small;
  final double medium;
  final double large;

  const AppRadiusExtension({
    required this.small,
    required this.medium,
    required this.large,
  });

  @override
  AppRadiusExtension copyWith({
    double? small,
    double? medium,
    double? large,
  }) {
    return AppRadiusExtension(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
    );
  }

  @override
  AppRadiusExtension lerp(ThemeExtension<AppRadiusExtension>? other, double t) {
    if (other is! AppRadiusExtension) return this;
    return AppRadiusExtension(
      small: lerpDouble(small, other.small, t)!,
      medium: lerpDouble(medium, other.medium, t)!,
      large: lerpDouble(large, other.large, t)!,
    );
  }
}
