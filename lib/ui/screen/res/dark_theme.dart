import 'package:flutter/material.dart';

import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_typography.dart';

class DarkTheme {
  final darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.darkThemeBgColor,
  appBarTheme: const AppBarTheme(
    toolbarHeight: 86,
    titleTextStyle: AppTypography.appBarTitleDarkMode,
    backgroundColor: AppColors.darkThemeBgColor,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkThemeBgColor,
  ),
  dividerColor: AppColors.secondaryTwo,
);
}