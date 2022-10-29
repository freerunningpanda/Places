import 'package:flutter/material.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/widgets/sight_icons.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.splashScreenBackground,
        ),
      ),
      child: Center(
        child: SightIcons(
          assetName: AppAssets.subtract,
          width: 160,
          height: 160,
        ),
      ),
    );
  }
}
