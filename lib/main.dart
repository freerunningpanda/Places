import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/screen/res/app_theme.dart';
import 'package:places/ui/screen/visiting_screen.dart';

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
  bool isDarkMode = true;

  @override
  void initState() {
    if (isDarkMode) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: AppColors.darkThemeBgColor,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: AppColors.black,
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: VisitingScreen(isDarkMode: isDarkMode),
      // SightListScreen(isDarkMode: isDarkMode),
    );
  }
}
