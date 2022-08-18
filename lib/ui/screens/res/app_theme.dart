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
        titleLarge: AppTypography.visitingScreenTitle,
        titleMedium: AppTypography.textText16Regular,
        bodySmall: AppTypography.detailsText,
        displayMedium: AppTypography.distantion,
        displaySmall: AppTypography.sightDetailsDescription,
        labelSmall: AppTypography.filtersItems,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.darkThemeBgColor,
      ),
      toggleableActiveColor: AppColors.backgroundColor,
      highlightColor: AppColors.inactiveBlack,
      canvasColor: AppColors.lightGreen,
      focusColor: AppColors.chevroneColor,
      // sliderTheme: SliderThemeData(
      //   trackHeight: 1,
      //   inactiveTrackColor: Colors.grey,
      //   activeTrackColor: Colors.green,
      //   thumbColor: Colors.white,
      //   overlayShape: SliderComponentShape.noOverlay,
      //   rangeThumbShape: RoundRangeSliderThumbShape(
      //     elevation: 3,
      //   ),
      // ),
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
        titleLarge: AppTypography.visitingScreenTitleDarkMode,
        titleMedium: AppTypography.textText16Regular,
        bodySmall: AppTypography.detailsTextDarkMode,
        displayMedium: AppTypography.distantionDarkMode,
        displaySmall: AppTypography.sightDetailsDescriptionDarkMode,
        labelSmall: AppTypography.filtersItemsDarkMode,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.backgroundColor,
      ),
      toggleableActiveColor: AppColors.textColor,
      highlightColor: AppColors.inactiveBlack,
      canvasColor: AppColors.lightGreen,
      focusColor: AppColors.chevroneColor,
    );
  }
}
