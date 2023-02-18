import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/details_screen/details_screen_bloc.dart';
import 'package:places/blocs/favorite/favorite_bloc.dart';
import 'package:places/blocs/search_bar/search_bar_bloc.dart';
import 'package:places/blocs/search_history/search_history_bloc.dart';
import 'package:places/blocs/search_screen/search_screen_bloc.dart';
import 'package:places/blocs/visited/visited_screen_bloc.dart';
import 'package:places/blocs/want_to_visit/want_to_visit_bloc.dart';
import 'package:places/cubits/places_list/places_list_cubit.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/providers/add_sight_provider.dart';
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

// ignore: long-method
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryDataProvider>(
          create: (_) => CategoryDataProvider(),
        ),
        ChangeNotifierProvider<AddSightScreenProvider>(
          create: (_) => AddSightScreenProvider(),
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
        Provider<PlaceRepository>(
          create: (_) => PlaceRepository(
            apiPlaces: ApiPlaces(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WantToVisitBloc>(
            create: (context) => WantToVisitBloc(),
          ),
          BlocProvider<VisitedScreenBloc>(
            create: (context) => VisitedScreenBloc(),
          ),
          BlocProvider<SearchScreenBloc>(
            create: (context) => SearchScreenBloc(),
          ),
          BlocProvider<SearchHistoryBloc>(
            create: (context) => SearchHistoryBloc(),
          ),
          BlocProvider<SearchBarBloc>(
            create: (context) => SearchBarBloc(),
          ),
          BlocProvider<PlacesListCubit>(
            create: (context) => PlacesListCubit(),
          ),
          BlocProvider<DetailsScreenBloc>(
            create: (context) => DetailsScreenBloc(),
          ),
          BlocProvider<FavoriteBloc>(
            create: (context) => FavoriteBloc(),
          ),
        ],
        child: const App(),
      ),
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
