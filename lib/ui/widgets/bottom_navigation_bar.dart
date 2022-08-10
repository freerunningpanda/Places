import 'package:flutter/material.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/widgets/sight_icons.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            // color: isDarkMode ? AppColors.inactiveBlack : AppColors.transparent,
          ),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: const SightIcons(
                assetName: AppAssets.listPlaces,
                width: 24,
                height: 24,
                // color: isDarkMode ? AppColors.backgroundColor : AppColors.darkThemeBgColor,
              ),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: SightIcons(
              assetName: AppAssets.map,
              width: 24,
              height: 24,
              // color: isDarkMode ? AppColors.backgroundColor : AppColors.darkThemeBgColor,
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: SightIcons(
              assetName: AppAssets.heartFull,
              width: 24,
              height: 24,
              // color: isDarkMode ? AppColors.backgroundColor : AppColors.darkThemeBgColor,
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: SightIcons(
              assetName: AppAssets.settings,
              width: 24,
              height: 24,
              // color: isDarkMode ? AppColors.backgroundColor : AppColors.darkThemeBgColor,
            ),
            label: '',
            
          ),
        ],
      ),
    );
  }
}
