import 'package:flutter/material.dart';

import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/res/custom_colors.dart';

abstract class AppTheme {
  // ignore: long-method
  static ThemeData buildTheme() {
    return ThemeData(
      timePickerTheme: TimePickerThemeData(
        hourMinuteTextColor: AppColors.backgroundColor,
        hourMinuteColor: AppColors.green,
        hourMinuteTextStyle: AppTypography.hourMinute,
        dialBackgroundColor: AppColors.dialBackgroundColor,
        dialHandColor: AppColors.green,
        backgroundColor: AppColors.backgroundColor,
        dayPeriodShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.transparent,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbVisibility: MaterialStateProperty.all(true),
        thickness: MaterialStateProperty.all(8),
        thumbColor: MaterialStateProperty.all(AppColors.chevroneColor),
        radius: const Radius.circular(6),
      ),
      tabBarTheme: TabBarTheme(
        unselectedLabelStyle: AppTypography.placeDetailsButtonNameInnactive,
        unselectedLabelColor: AppColors.inactiveBlack,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.textColor,
        ),
        labelColor: AppColors.backgroundColor,
        labelStyle: AppTypography.tabBarLabelStyle,
      ),
      cardColor: AppColors.red,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        circularTrackColor: AppColors.placeCardBackground,
        color: AppColors.secondaryTwo,
      ),
      extensions: const <ThemeExtension<CustomColors>>[CustomColors.placeCardLight],
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          foregroundColor: AppColors.black,
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
      dividerColor: AppColors.inactiveBlack,
      textTheme: const TextTheme(
        headlineMedium: AppTypography.placeDetailsTitle,
        headlineSmall: AppTypography.placeCardDescriptionTitle,
        titleSmall: AppTypography.placeDetailsSubtitle,
        titleLarge: AppTypography.visitingScreenTitle,
        titleMedium: AppTypography.textText16Regular,
        bodyLarge: AppTypography.settings,
        bodyMedium: AppTypography.clearButton,
        bodySmall: AppTypography.detailsText,
        displayLarge: AppTypography.addNewPlaceCancel,
        displayMedium: AppTypography.distantion,
        displaySmall: AppTypography.placeDetailsDescription,
        labelSmall: AppTypography.filtersItems,
        labelLarge: AppTypography.categoriesGrey,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.darkThemeBgColor,
      ),
      highlightColor: AppColors.inactiveBlack,
      canvasColor: AppColors.lightGreen,
      disabledColor: AppColors.chevroneColor,
      focusColor: AppColors.chevroneColor,
      sliderTheme: SliderThemeData(
        activeTickMarkColor: AppColors.greenOpacity,
        overlayColor: AppColors.greenOpacityTextField,
        trackHeight: 1,
        inactiveTrackColor: AppColors.inactiveBlack,
        activeTrackColor: AppColors.green,
        thumbColor: AppColors.backgroundColor,
        overlayShape: SliderComponentShape.noOverlay,
        rangeThumbShape: const RoundRangeSliderThumbShape(elevation: 3),
      ),
    );
  }

  // ignore: long-method
  static ThemeData buildThemeDark() {
    return ThemeData(
      timePickerTheme: TimePickerThemeData(
        hourMinuteColor: AppColors.green,
        hourMinuteTextStyle: AppTypography.hourMinute,
        dialBackgroundColor: AppColors.dialBackgroundColor,
        dialHandColor: AppColors.green,
        backgroundColor: AppColors.backgroundColor,
        dayPeriodShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.transparent,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbVisibility: MaterialStateProperty.all(true),
        thickness: MaterialStateProperty.all(8),
        thumbColor: MaterialStateProperty.all(AppColors.backgroundColor),
        radius: const Radius.circular(6),
      ),
      tabBarTheme: TabBarTheme(
        unselectedLabelStyle: AppTypography.placeDetailsButtonNameInnactive,
        unselectedLabelColor: AppColors.inactiveBlack,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.backgroundColor,
        ),
        labelColor: AppColors.textColor,
        labelStyle: AppTypography.tabBarLabelStyle,
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
      dividerColor: AppColors.inactiveBlack,
      textTheme: const TextTheme(
        headlineMedium: AppTypography.placeDetailsTitleDarkMode,
        headlineSmall: AppTypography.placeCardDescriptionTitleDarkMode,
        titleSmall: AppTypography.placeDetailsSubtitleDarkMode,
        titleLarge: AppTypography.visitingScreenTitleDarkMode,
        titleMedium: AppTypography.textText16Regular,
        bodyLarge: AppTypography.settingsDarkMode,
        bodyMedium: AppTypography.clearButton,
        bodySmall: AppTypography.detailsTextDarkMode,
        displayLarge: AppTypography.addNewPlaceCancel,
        displayMedium: AppTypography.distantionDarkMode,
        displaySmall: AppTypography.placeDetailsDescriptionDarkMode,
        labelSmall: AppTypography.filtersItemsDarkMode,
        labelLarge: AppTypography.categoriesGrey,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.backgroundColor,
      ),
      highlightColor: AppColors.inactiveBlack,
      canvasColor: AppColors.lightGreen,
      disabledColor: AppColors.backgroundColor,
      focusColor: AppColors.chevroneColor,
      sliderTheme: SliderThemeData(
        activeTickMarkColor: AppColors.greenOpacity,
        trackHeight: 1,
        inactiveTrackColor: AppColors.inactiveBlack,
        activeTrackColor: AppColors.green,
        overlayColor: AppColors.greenOpacityTextField,
        thumbColor: AppColors.backgroundColor,
        overlayShape: SliderComponentShape.noOverlay,
        rangeThumbShape: const RoundRangeSliderThumbShape(elevation: 3),
      ),
      extensions: const <ThemeExtension<CustomColors>>[CustomColors.placeCardDark],
    );
  }
}
