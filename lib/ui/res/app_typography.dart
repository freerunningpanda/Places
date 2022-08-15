import 'package:flutter/material.dart';
import 'package:places/ui/res/app_colors.dart';

abstract class AppTypography {
  static const textText16Regular = TextStyle(
    fontSize: 16,
    height: 1.25,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryTwo,
  );
  static const textText16Search = TextStyle(
    fontSize: 16,
    height: 1.25,
    fontWeight: FontWeight.w400,
    color: AppColors.inactiveBlack,
  );
  static const appBarTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textColor,
  );
  static const appBarTitleDarkMode = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.backgroundColor,
  );

  static const sightCardTitle = TextStyle(
    fontWeight: FontWeight.w700,
    color: AppColors.backgroundColor,
  );

  static const tabBarIndicator = TextStyle(
    fontWeight: FontWeight.w700,
    color: AppColors.chevroneColor,
  );

  static const disabledTabDarkMode = TextStyle(
    fontWeight: FontWeight.w700,
    color: AppColors.inactiveBlack,
  );

  static const sightCardDescriptionTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textColor,
  );
  static const sightCardDescriptionTitleDarkMode = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.backgroundColor,
  );
  static const visitingScreenTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.chevroneColor,
  );
  static const visitingScreenTitleDarkMode = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.backgroundColor,
  );

  static const sightDetailsTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textColor,
  );

  static const sightDetailsTitleDarkMode = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.backgroundColor,
  );

  static const sightDetailsSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textColor,
  );

  static const sightDetailsSubtitleDarkMode = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.secondaryTwo,
  );

  static const detailsText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryTwo,
  );

  static const detailsTextDarkMode = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.inactiveBlack,
  );

  static const emptyListTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.inactiveBlack,
  );
  static const emptyListSubTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.inactiveBlack,
  );

  static const sightDetailsDescription = TextStyle(
    fontSize: 14,
    color: AppColors.textColor,
  );
  static const sightDetailsDescriptionDarkMode = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.backgroundColor,
  );

  static const sightDetailsButtonName = TextStyle(
    fontWeight: FontWeight.w700,
    color: AppColors.backgroundColor,
  );

  static const inactiveButton = TextStyle(
    color: AppColors.inactiveColor,
  );

  static const activeButton = TextStyle(
    color: AppColors.textColor,
  );

  static const activeButtonDarkMode = TextStyle(
    color: AppColors.backgroundColor,
  );

  static const greenColor = TextStyle(
    color: AppColors.green,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const clearButton = TextStyle(
    color: AppColors.green,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const categoriesGrey = TextStyle(
    color: AppColors.inactiveBlack,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}
