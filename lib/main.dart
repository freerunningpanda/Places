import 'package:flutter/material.dart';

import 'package:places/providers/add_place_data_provider.dart';
import 'package:places/providers/category_data_provider.dart';
import 'package:places/providers/dismissible_data_provider.dart';
import 'package:places/providers/filter_data_provider.dart';
import 'package:places/providers/image_data_provider.dart';
import 'package:places/providers/search_data_provider.dart';
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
        ChangeNotifierProvider<ImageDataProvider>(
          create: (_) => ImageDataProvider(),
        ),
        ChangeNotifierProvider<ThemeDataProvider>(
          create: (_) => ThemeDataProvider(),
        ),
        ChangeNotifierProvider<SearchDataProvider>(
          create: (_) => SearchDataProvider(),
        ),
        ChangeNotifierProvider<FilterDataProvider>(
          create: (_) => FilterDataProvider(),
        ),
        ChangeNotifierProvider<DismissibleDataProvider>(
          create: (_) => DismissibleDataProvider(),
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
      theme: isDarkMode ? _darkTheme : _lightTheme,
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
