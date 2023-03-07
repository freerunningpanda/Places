import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/choose_category_bloc/choose_category_bloc.dart';
import 'package:places/blocs/details_screen/details_screen_bloc.dart';
import 'package:places/blocs/favorite/favorite_bloc.dart';
import 'package:places/blocs/filters_screen_bloc/filters_screen_bloc.dart';
import 'package:places/blocs/search_bar/search_bar_bloc.dart';
import 'package:places/blocs/search_history/search_history_bloc.dart';
import 'package:places/blocs/search_screen/search_screen_bloc.dart';
import 'package:places/blocs/visited/visited_screen_bloc.dart';
import 'package:places/blocs/want_to_visit/want_to_visit_bloc.dart';
import 'package:places/cubits/add_sight_screen/add_sight_screen_cubit.dart';
import 'package:places/cubits/create_place/create_place_button_cubit.dart';
import 'package:places/cubits/distance_slider_cubit/distance_slider_cubit.dart';
import 'package:places/cubits/places_list/places_list_cubit.dart';
import 'package:places/cubits/show_places_button/show_places_button_cubit.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/providers/image_data_provider.dart';
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
        ChangeNotifierProvider<ImageDataProvider>(
          create: (_) => ImageDataProvider(), // Переписать на блок, когда пройду тему с загрузкой изображений
          // Сейчас это бутофория
        ),
        ChangeNotifierProvider<ThemeDataProvider>(
          create: (_) => ThemeDataProvider(),
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
          BlocProvider<ChooseCategoryBloc>(
            create: (context) => ChooseCategoryBloc(),
          ),
          BlocProvider<ChooseCategoryBloc>(
            create: (context) => ChooseCategoryBloc(),
          ),
          BlocProvider<AddSightScreenCubit>(
            create: (context) => AddSightScreenCubit(),
          ),
          BlocProvider<CreatePlaceButtonCubit>(
            create: (context) => CreatePlaceButtonCubit(),
          ),
          BlocProvider<FiltersScreenBloc>(
            create: (context) => FiltersScreenBloc(),
          ),
          BlocProvider<DistanceSliderCubit>(
            create: (context) => DistanceSliderCubit(),
          ),
          BlocProvider<ShowPlacesButtonCubit>(
            create: (context) => ShowPlacesButtonCubit(),
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
