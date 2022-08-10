import 'package:flutter/material.dart';

import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_typography.dart';

abstract class AppTheme {
  static ThemeData buildTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.backgroundColor,
      appBarTheme: const AppBarTheme(
        toolbarHeight: 86,
        titleTextStyle: AppTypography.appBarTitle,
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        headlineSmall: AppTypography.sightCardDescriptionTitle,
        bodyMedium: AppTypography.detailsText, 
      ),
    );
  }

  static ThemeData buildThemeDark() {
    return ThemeData(
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
      // primaryTextTheme: const TextTheme(
      //   headline3: AppTypography.sightCardDescriptionTitleDarkMode,
      // ),
      textTheme: const TextTheme(
        headlineSmall: AppTypography.sightCardDescriptionTitleDarkMode,
        bodyMedium: AppTypography.detailsText,       
      ),
    );
  }
}
