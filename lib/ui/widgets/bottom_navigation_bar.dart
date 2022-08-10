import 'package:flutter/material.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/widgets/sight_icons.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.highlightColor,
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
                color: theme.iconTheme.color,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SightIcons(
              assetName: AppAssets.map,
              width: 24,
              height: 24,
              color: theme.iconTheme.color,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SightIcons(
              assetName: AppAssets.heartFull,
              width: 24,
              height: 24,
              color: theme.iconTheme.color,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SightIcons(
              assetName: AppAssets.settings,
              width: 24,
              height: 24,
              color: theme.iconTheme.color,
            ),
            label: '',
            
          ),
        ],
      ),
    );
  }
}
