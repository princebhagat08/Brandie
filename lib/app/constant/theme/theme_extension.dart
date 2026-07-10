import 'package:flutter/material.dart';
import 'app_theme_colors.dart';

extension ThemeExtension on BuildContext {

  TextTheme get text => Theme.of(this).textTheme;

  ColorScheme get colors => Theme.of(this).colorScheme;

  ThemeData get theme => Theme.of(this);

  AppThemeColors get appColors =>
      Theme.of(this).extension<AppThemeColors>()!;
}