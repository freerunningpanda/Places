import 'package:flutter/material.dart';
import 'package:places/appsettings.dart';
import 'package:places/ui/screens/filters_screen/filters_settings.dart';
import 'package:places/ui/screens/navigation_screen/navigation_screen.dart';

import 'package:places/ui/screens/res/app_theme.dart';
import 'package:provider/provider.dart';

final ThemeData _lightTheme = AppTheme.buildTheme();
final ThemeData _darkTheme = AppTheme.buildThemeDark();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppSettings>(
          create: (_) => AppSettings(),
        ),
        ChangeNotifierProvider<FiltersSettings>(
          create: (_) => FiltersSettings(),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<AppSettings>().isDarkMode;

    return MaterialApp(
      theme: !isDarkMode ? _lightTheme : _darkTheme,
      debugShowCheckedModeBanner: false,
      title: 'Places',
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NavigationScreen();
  }
}
