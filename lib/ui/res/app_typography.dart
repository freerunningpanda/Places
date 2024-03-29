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

  static const placeCardTitle = TextStyle(
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

  static const placeCardDescriptionTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textColor,
  );
  static const addNewPlaceCancel = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryTwo,
  );
  static const placeCardDescriptionTitleDarkMode = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.backgroundColor,
  );
  static const removeCardText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.backgroundColor,
  );
  static const visitingScreenTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.chevroneColor,
  );
  static const settings = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.chevroneColor,
  );
  static const settingsDarkMode = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.backgroundColor,
  );
  static const visitingScreenTitleDarkMode = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.backgroundColor,
  );

  static const placeDetailsTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textColor,
  );

  static const placeDetailsTitleDarkMode = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.backgroundColor,
  );

  static const placeDetailsSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textColor,
  );

  static const placeDetailsSubtitleDarkMode = TextStyle(
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

  static const placeDetailsDescription = TextStyle(
    fontSize: 14,
    color: AppColors.textColor,
  );
  static const placeDetailsDescriptionDarkMode = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.backgroundColor,
  );

  static const placeDetailsButtonName = TextStyle(
    fontWeight: FontWeight.w700,
    color: AppColors.backgroundColor,
  );

  static const placeDetailsButtonNameInnactive = TextStyle(
    fontWeight: FontWeight.w700,
    color: AppColors.inactiveBlack,
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

  static const filtersItemsDarkMode = TextStyle(
    color: AppColors.backgroundColor,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static const filtersItems = TextStyle(
    color: AppColors.textColor,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const distantion = TextStyle(
    color: AppColors.textColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const distantionDarkMode = TextStyle(
    color: AppColors.backgroundColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const tabBarLabelStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w700);
  static const cancelButtonStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.green,
  );

  static const hourMinute = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w400,
    color: AppColors.backgroundColor,
  );
}
