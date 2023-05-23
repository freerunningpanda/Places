import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:places/app.dart';
import 'package:places/blocs/choose_category_bloc/choose_category_bloc.dart';
import 'package:places/blocs/details_screen/details_screen_bloc.dart';
import 'package:places/blocs/filters_screen_bloc/filters_screen_bloc.dart';
import 'package:places/blocs/search_bar/search_bar_bloc.dart';
import 'package:places/blocs/search_history/search_history_bloc.dart';
import 'package:places/blocs/search_screen/search_screen_bloc.dart';
import 'package:places/blocs/visited/visited_screen_bloc.dart';
import 'package:places/blocs/want_to_visit/want_to_visit_bloc.dart';
import 'package:places/cubits/add_place_screen/add_place_screen_cubit.dart';
import 'package:places/cubits/create_place/create_place_button_cubit.dart';
import 'package:places/cubits/distance_slider_cubit/distance_slider_cubit.dart';
import 'package:places/cubits/places_list/places_list_cubit.dart';
import 'package:places/cubits/show_places_button/show_places_button_cubit.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/store/app_preferences.dart';
import 'package:places/environment/build_config.dart';
import 'package:places/environment/build_type.dart';
import 'package:places/environment/environment.dart';
import 'package:places/providers/map_data_provider.dart';
import 'package:places/providers/theme_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

final AppDb db = AppDb();
Position? position;
Point? currentPoint;

Future<void> getPosition() async {
  position = await Geolocator.getCurrentPosition();
  currentPoint =
      Point(latitude: position!.latitude, longitude: position!.longitude);
}

// ignore: long-method
void main() async {
  _defineEnvironment(
    buildConfig: _setUpConfig(),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.init();
  AndroidYandexMap.useAndroidViewSurface = false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeDataProvider>(
          create: (_) => ThemeDataProvider(),
        ),
        Provider<AppDb>(
          create: (_) => db,
        ),
        Provider<MapDataProvider>(
          create: (_) => MapDataProvider(),
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
        ],
        child: const App(),
      ),
    ),
  );
}

void _defineEnvironment({required BuildConfig buildConfig}) {
  Environment.init(
    buildConfig: buildConfig,
    buildType: BuildType.debug,
  );
}

BuildConfig _setUpConfig() {
  return BuildConfig(
    envString: 'Debug сборка приложения',
  );
}
