import 'package:flutter/material.dart';

import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/res/custom_colors.dart';

abstract class AppTheme {
  static ThemeData buildTheme() {
    return ThemeData(
      extensions: const <ThemeExtension<CustomColors>>[CustomColors.sightCardLight],
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: AppColors.black,
        ),
      ),
      scaffoldBackgroundColor: AppColors.backgroundColor,
      appBarTheme: const AppBarTheme(
        toolbarHeight: 86,
        titleTextStyle: AppTypography.appBarTitle,
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.backgroundColor,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.inactiveBlack,
      ),
      textTheme: const TextTheme(
        headlineMedium: AppTypography.sightDetailsTitle,
        headlineSmall: AppTypography.sightCardDescriptionTitle,
        titleSmall: AppTypography.sightDetailsSubtitle,
        titleLarge: AppTypography.visitingScreenTitle,
        titleMedium: AppTypography.textText16Regular,
        bodyLarge: AppTypography.settings,
        bodyMedium: AppTypography.detailsText,
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
      sliderTheme: SliderThemeData(
        trackHeight: 1,
        inactiveTrackColor: AppColors.inactiveBlack,
        activeTrackColor: AppColors.green,
        thumbColor: AppColors.backgroundColor,
        overlayShape: SliderComponentShape.noOverlay,
        rangeThumbShape: const RoundRangeSliderThumbShape(elevation: 3),
      ),
    );
  }

  static ThemeData buildThemeDark() {
    return ThemeData(
      extensions: const <ThemeExtension<CustomColors>>[CustomColors.sightCardDark],
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: AppColors.black,
        ),
      ),
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
        titleSmall: AppTypography.sightDetailsSubtitleDarkMode,
        titleLarge: AppTypography.visitingScreenTitleDarkMode,
        titleMedium: AppTypography.textText16Regular,
        bodyLarge: AppTypography.settingsDarkMode,
        bodyMedium: AppTypography.detailsText,
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
      sliderTheme: SliderThemeData(
        trackHeight: 1,
        inactiveTrackColor: AppColors.inactiveBlack,
        activeTrackColor: AppColors.green,
        thumbColor: AppColors.backgroundColor,
        overlayShape: SliderComponentShape.noOverlay,
        rangeThumbShape: const RoundRangeSliderThumbShape(elevation: 3),
      ),
    );
  }
}
