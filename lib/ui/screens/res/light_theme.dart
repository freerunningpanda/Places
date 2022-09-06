import 'package:flutter/material.dart';

import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_typography.dart';

class LightTheme {
  final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      toolbarHeight: 86,
      titleTextStyle: AppTypography.appBarTitle,
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
    ),
  );
}