import 'package:flutter/material.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/screens/map_screen/map_screen.dart';
import 'package:places/ui/screens/place_list_screen/place_list_screen.dart';
import 'package:places/ui/screens/settings_screen/settings_screen.dart';
import 'package:places/ui/screens/visiting_screen/visiting_screen.dart';
import 'package:places/ui/widgets/place_icons.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final screens = const [
    PlaceListScreen(
      key: PageStorageKey<String>('PlaceListScreen'),
    ),
    MapScreen(),
    VisitingScreen(),
    SettingsScreen(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: theme.highlightColor,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: PlaceIcons(
                assetName: currentIndex == 0 ? AppAssets.listPlacesFilled : AppAssets.listPlaces,
                width: 24,
                height: 24,
                color: theme.iconTheme.color,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: PlaceIcons(
                assetName: currentIndex == 1 ? AppAssets.mapFull : AppAssets.map,
                width: 24,
                height: 24,
                color: theme.iconTheme.color,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: PlaceIcons(
                assetName: currentIndex == 2 ? AppAssets.heartFullDark : AppAssets.favouriteDark,
                width: 24,
                height: 24,
                color: theme.iconTheme.color,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: PlaceIcons(
                assetName: currentIndex == 3 ? AppAssets.settingsFill : AppAssets.settings,
                width: 24,
                height: 24,
                color: theme.iconTheme.color,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
