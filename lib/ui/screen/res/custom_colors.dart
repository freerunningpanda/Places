import 'package:flutter/material.dart';
import 'package:places/ui/res/app_colors.dart';

class CustomColors extends ThemeExtension<CustomColors> {
  static final sightCardLight = CustomColors(sightCardColor: AppColors.sightCardBackground);
  static final sightCardDark = CustomColors(sightCardColor: AppColors.darkThemeSightCardColor);
  

  final Color? sightCardColor;

  CustomColors({required this.sightCardColor});

  @override
  ThemeExtension<CustomColors> copyWith({Color? sightCardColor}) {
    return CustomColors(sightCardColor: sightCardColor);
  }

  @override
  ThemeExtension<CustomColors> lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }

    return CustomColors(sightCardColor: sightCardColor);
  }
}
