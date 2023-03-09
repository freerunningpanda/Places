import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/ui/res/app_colors.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  static const placeCardLight = CustomColors(
    color: AppColors.placeCardBackground,
  );

  static const placeCardDark = CustomColors(
    color: AppColors.placeCardBackgroundDM,
  );

  final Color? color;

  const CustomColors({required this.color});

  @override
  ThemeExtension<CustomColors> copyWith({Color? placeCardColor, SystemUiOverlayStyle? systemColor}) {
    return CustomColors(color: placeCardColor);
  }

  @override
  ThemeExtension<CustomColors> lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }

    return CustomColors(color: color);
  }
}
