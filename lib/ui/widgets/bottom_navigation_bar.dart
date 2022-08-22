import 'package:flutter/material.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/screens/settings_screen/settings_screen.dart';
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
        backgroundColor: theme.scaffoldBackgroundColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () => debugPrint('Places pressed'),
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
            icon: GestureDetector(
              onTap: () => debugPrint('Route pressed'),
              child: SightIcons(
                assetName: AppAssets.map,
                width: 24,
                height: 24,
                color: theme.iconTheme.color,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () => debugPrint('Favourite pressed'),
              child: SightIcons(
                assetName: AppAssets.heartFull,
                width: 24,
                height: 24,
                color: theme.iconTheme.color,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                debugPrint('Settings pressed');
                Navigator.push(
                  context,
                  MaterialPageRoute<SettingsScreen>(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              child: SightIcons(
                assetName: AppAssets.settings,
                width: 24,
                height: 24,
                color: theme.iconTheme.color,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
