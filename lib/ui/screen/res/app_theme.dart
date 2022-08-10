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
      dividerTheme: const DividerThemeData(
        color: AppColors.inactiveBlack,
      ),
      textTheme: const TextTheme(
        headlineMedium: AppTypography.sightDetailsTitle,
        headlineSmall: AppTypography.sightCardDescriptionTitle,
        bodyMedium: AppTypography.detailsText,
        titleSmall: AppTypography.sightDetailsSubtitle,    
        bodySmall: AppTypography.detailsText,   
        displaySmall: AppTypography.sightDetailsDescription,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.darkThemeBgColor,
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
      dividerTheme: const DividerThemeData(
        color: AppColors.secondaryTwo,
      ),
      textTheme: const TextTheme(
        headlineMedium: AppTypography.sightDetailsTitleDarkMode,
        headlineSmall: AppTypography.sightCardDescriptionTitleDarkMode,
        bodyMedium: AppTypography.detailsText,
        titleSmall: AppTypography.sightDetailsSubtitleDarkMode,    
        bodySmall: AppTypography.detailsTextDarkMode,   
        displaySmall: AppTypography.sightDetailsDescriptionDarkMode,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.backgroundColor,
      ),
    );
  }
}
