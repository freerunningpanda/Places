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
import 'package:places/cubits/add_place_screen/add_place_screen_cubit.dart';
import 'package:places/cubits/create_place/create_place_button_cubit.dart';
import 'package:places/cubits/distance_slider_cubit/distance_slider_cubit.dart';
import 'package:places/cubits/image_provider/image_provider_cubit.dart';
import 'package:places/cubits/places_list/places_list_cubit.dart';
import 'package:places/cubits/show_places_button/show_places_button_cubit.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/store/app_preferences.dart';
import 'package:places/providers/theme_data_provider.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screens/onboarding_screen/onboarding_screen.dart';
import 'package:places/ui/screens/res/app_theme.dart';
import 'package:places/ui/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

final ThemeData _lightTheme = AppTheme.buildTheme();
final ThemeData _darkTheme = AppTheme.buildThemeDark();
final AppDb db = AppDb();

// ignore: long-method
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeDataProvider>(
          create: (_) => ThemeDataProvider(),
        ),
        Provider<AppDb>(
          create: (_) => db,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WantToVisitBloc>(
            create: (_) => WantToVisitBloc(
              db: db,
            )..add(
                FavoriteListLoadedEvent(),
              ),
          ),
          BlocProvider<VisitedScreenBloc>(
            create: (_) => VisitedScreenBloc(db: db)
              ..add(
                VisitedListLoadedEvent(),
              ),
          ),
          BlocProvider<SearchScreenBloc>(
            create: (_) => SearchScreenBloc(),
          ),
          BlocProvider<SearchHistoryBloc>(
            create: (_) => SearchHistoryBloc(),
          ),
          BlocProvider<SearchBarBloc>(
            create: (_) => SearchBarBloc(),
          ),
          BlocProvider<PlacesListCubit>(
            create: (_) => PlacesListCubit(),
          ),
          BlocProvider<DetailsScreenBloc>(
            create: (_) => DetailsScreenBloc(),
          ),
          BlocProvider<FavoriteBloc>(
            create: (_) => FavoriteBloc(),
          ),
          BlocProvider<ChooseCategoryBloc>(
            create: (_) => ChooseCategoryBloc(),
          ),
          BlocProvider<ChooseCategoryBloc>(
            create: (_) => ChooseCategoryBloc(),
          ),
          BlocProvider<AddPlaceScreenCubit>(
            create: (_) => AddPlaceScreenCubit(),
          ),
          BlocProvider<CreatePlaceButtonCubit>(
            create: (_) => CreatePlaceButtonCubit(),
          ),
          BlocProvider<FiltersScreenBloc>(
            create: (_) => FiltersScreenBloc(),
          ),
          BlocProvider<DistanceSliderCubit>(
            create: (_) => DistanceSliderCubit(),
          ),
          BlocProvider<ShowPlacesButtonCubit>(
            create: (_) => ShowPlacesButtonCubit(),
          ),
          BlocProvider<ImageProviderCubit>(
            create: (_) => ImageProviderCubit(),
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
