import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/ui/res/app_colors.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  static const sightCardLight = CustomColors(
    color: AppColors.sightCardBackground,
  );

  static const sightCardDark = CustomColors(
    color: AppColors.sightCardBackgroundDM,
  );

  final Color? color;

  const CustomColors({required this.color});

  @override
  ThemeExtension<CustomColors> copyWith({Color? sightCardColor, SystemUiOverlayStyle? systemColor}) {
    return CustomColors(color: sightCardColor);
  }

  @override
  ThemeExtension<CustomColors> lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }

    return CustomColors(color: color);
  }
}
