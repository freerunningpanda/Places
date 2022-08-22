import 'package:flutter/material.dart';
import 'package:places/appsettings.dart';
import 'package:places/ui/screens/navigation_screen/navigation_screen.dart';

import 'package:places/ui/screens/res/app_theme.dart';
import 'package:places/ui/screens/res/custom_colors.dart';
import 'package:provider/provider.dart';

final ThemeData _lightTheme = AppTheme.buildTheme();
final ThemeData _darkTheme = AppTheme.buildThemeDark();

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppSettings>(
        create: (_) => AppSettings(),
      ),
    ],
    child: const App(),
  ));
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
    return Consumer<AppSettings>(builder: (context, model, child) {
      final isDarkMode = model.isDarkMode;

      return MaterialApp(
        theme: !isDarkMode
            ? _lightTheme.copyWith(
                extensions: <ThemeExtension<dynamic>>[
                  CustomColors.sightCardLight,
                ],
              )
            : _darkTheme.copyWith(
                extensions: <ThemeExtension<dynamic>>[
                  CustomColors.sightCardDark,
                ],
              ),
        debugShowCheckedModeBanner: false,
        title: 'Places',
        home: const MainScreen(),
        // const SightListScreen(),
      );
    });
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NavigationScreen();
  }
}
