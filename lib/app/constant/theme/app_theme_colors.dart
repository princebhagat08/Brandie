import 'package:flutter/material.dart';

@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final Color inputBg;
  final Color cardBg;
  final Color border;
  final Color divider;
  final Color success;
  final Color warning;
  final Color countryCodeBg;
  final Color iconColor;
  final Color iconBg;
  final Color black;

  const AppThemeColors({
    required this.inputBg,
    required this.cardBg,
    required this.border,
    required this.divider,
    required this.success,
    required this.warning,
    required this.countryCodeBg,
    required this.iconColor,
    required this.iconBg,
    required this.black
  });

  @override
  AppThemeColors copyWith({
    Color? inputBg,
    Color? cardBg,
    Color? border,
    Color? divider,
    Color? success,
    Color? warning,
    Color? countryCodeBg,
    Color? iconColor,
    Color? iconBg,
    Color? black
  }) {
    return AppThemeColors(
      inputBg: inputBg ?? this.inputBg,
      cardBg: cardBg ?? this.cardBg,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      countryCodeBg: countryCodeBg ?? this.countryCodeBg,
      iconColor: iconColor ?? this.iconColor,
      iconBg: iconBg ?? this.iconBg,
      black: black ?? this.black
    );
  }

  @override
  AppThemeColors lerp(
    ThemeExtension<AppThemeColors>? other,
    double t,
  ) {
    if (other is! AppThemeColors) return this;

    return AppThemeColors(
      inputBg: Color.lerp(inputBg, other.inputBg, t)!,
      cardBg: Color.lerp(cardBg, other.cardBg, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      countryCodeBg: Color.lerp(countryCodeBg, other.countryCodeBg, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      iconBg: Color.lerp(iconBg, other.iconBg, t)!,
      black: Color.lerp(black, other.black, t)!
    );
  }
}