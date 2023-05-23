import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/cubits/places_list/places_list_cubit.dart';
import 'package:places/providers/theme_data_provider.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screens/onboarding_screen/onboarding_screen.dart';
import 'package:places/ui/screens/res/app_theme.dart';
import 'package:places/ui/screens/splash_screen/splash_screen.dart';

final ThemeData _lightTheme = AppTheme.buildTheme();
final ThemeData _darkTheme = AppTheme.buildThemeDark();

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
      // debugShowCheckedModeBanner: false,
      title: AppStrings.places,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesListCubit, PlacesListState>(
      builder: (_, state) {
        if (state is PlacesListLoadedState) {
          return const OnboardingScreen();
        } else if (state is PlacesListErrorState) {
          throw ArgumentError(state.error);
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}