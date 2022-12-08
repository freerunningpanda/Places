import 'package:flutter/material.dart';

import 'package:places/appsettings.dart';
import 'package:places/data/interactor/categories_table.dart';
import 'package:places/ui/screens/filters_screen/filters_settings.dart';
import 'package:places/ui/screens/res/app_theme.dart';
import 'package:places/ui/screens/splash_screen/splash_screen.dart';
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
        ChangeNotifierProvider<CategoriesTable>(
          create: (_) => CategoriesTable(),
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

  // Future<void> testNetworkCall() async {
  //   final dynamic response = PlaceInteractor(
  //     apiPlaceRepository: ApiPlaceRepository(),
  //   ).getPlaces();
  //   debugPrint('Response HTTP call: $response');
  // }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
