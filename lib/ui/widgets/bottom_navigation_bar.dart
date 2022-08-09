import 'package:flutter/material.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/widgets/sight_icons.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final bool isDarkMode;
  const BottomNavigationBarWidget({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: isDarkMode ? AppColors.inactiveBlack : AppColors.transparent,
          ),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: SightIcons(
                assetName: AppAssets.listPlaces,
                width: 24,
                height: 24,
                color: isDarkMode ? AppColors.backgroundColor : AppColors.darkThemeBgColor,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SightIcons(
              assetName: AppAssets.map,
              width: 24,
              height: 24,
              color: isDarkMode ? AppColors.backgroundColor : AppColors.darkThemeBgColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SightIcons(
              assetName: AppAssets.heartFull,
              width: 24,
              height: 24,
              color: isDarkMode ? AppColors.backgroundColor : AppColors.darkThemeBgColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SightIcons(
              assetName: AppAssets.settings,
              width: 24,
              height: 24,
              color: isDarkMode ? AppColors.backgroundColor : AppColors.darkThemeBgColor,
            ),
            label: '',
            
          ),
        ],
      ),
    );
  }
}
