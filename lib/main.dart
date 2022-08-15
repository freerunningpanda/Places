import 'package:flutter/material.dart';

import 'package:places/ui/screens/res/app_theme.dart';
import 'package:places/ui/screens/res/custom_colors.dart';
import 'package:places/ui/screens/sight_list_screen.dart';
import 'package:places/ui/screens/visiting_screen.dart';

final ThemeData _lightTheme = AppTheme.buildTheme();
final ThemeData _darkTheme = AppTheme.buildThemeDark();

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _lightTheme.copyWith(
        extensions: <ThemeExtension<dynamic>>[
          CustomColors.sightCardLight,
        ],
      ),
      darkTheme: _darkTheme.copyWith(
        extensions: <ThemeExtension<dynamic>>[
          CustomColors.sightCardDark,
        ],
      ),
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      title: 'Places',
      home:
      //  const VisitingScreen(),
      const SightListScreen(),
    );
  }
}
