import 'package:flutter/material.dart';

import 'package:places/providers/add_place_data_provider.dart';
import 'package:places/providers/category_data_provider.dart';
import 'package:places/providers/image_provider.dart' as image_provider;
import 'package:places/providers/places_functions_provider.dart';
import 'package:places/providers/theme_data_provider.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screens/res/app_theme.dart';
import 'package:places/ui/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

final ThemeData _lightTheme = AppTheme.buildTheme();
final ThemeData _darkTheme = AppTheme.buildThemeDark();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryDataProvider>(
          create: (_) => CategoryDataProvider(),
        ),
        ChangeNotifierProvider<AddPlaceDataProvider>(
          create: (_) => AddPlaceDataProvider(),
        ),
        ChangeNotifierProvider<PlacesFunctionsProvider>(
          create: (_) => PlacesFunctionsProvider(),
        ),
        ChangeNotifierProvider<image_provider.ImageProvider>(
          create: (_) => image_provider.ImageProvider(),
        ),
        ChangeNotifierProvider<ThemeDataProvider>(
          create: (_) => ThemeDataProvider(),
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
    final isDarkMode = context.watch<ThemeDataProvider>().isDarkMode;

    return MaterialApp(
      theme: !isDarkMode ? _lightTheme : _darkTheme,
      debugShowCheckedModeBanner: false,
      title: AppString.places,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
