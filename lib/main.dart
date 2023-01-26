import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/blocs/visiting_screen/visiting_screen_bloc.dart';
import 'package:places/blocs/visiting_screen/visiting_screen_event.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/repository/place_repository.dart';

import 'package:places/providers/dismissible_data_provider.dart';
import 'package:places/providers/filter_data_provider.dart';
import 'package:places/providers/image_data_provider.dart';
import 'package:places/providers/search_data_provider.dart';
import 'package:places/providers/theme_data_provider.dart';
import 'package:places/redux/action/action.dart';
import 'package:places/redux/reducer/reducer.dart';
import 'package:places/redux/state/appstate.dart';
import 'package:places/redux/state/search_screen_state.dart';
import 'package:places/store/place_list/place_list_store.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screens/add_sight_screen/add_sight_vm.dart';
import 'package:places/ui/screens/add_sight_screen/category_data_vm.dart';
import 'package:places/ui/screens/res/app_theme.dart';
import 'package:places/ui/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

final ThemeData _lightTheme = AppTheme.buildTheme();
final ThemeData _darkTheme = AppTheme.buildThemeDark();

// ignore: long-method
void main() {
  final store = Store<AppState>(
    reducer,
    initialState: AppState(
      searchScreenState: SearchScreenEmptyState(action: PlacesEmptyAction(),),
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryDataViewModel>(
          create: (_) => CategoryDataViewModel(),
        ),
        ChangeNotifierProvider<AddSightScreenViewModel>(
          create: (_) => AddSightScreenViewModel(),
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
        Provider<PlaceListStore>(
          create: (_) => PlaceListStore(
            placeRepository: PlaceRepository(
              apiPlaces: ApiPlaces(),
            ),
          ),
        ),
      ],
      child: BlocProvider<VisitingScreenBloc>(
        create: (context) => VisitingScreenBloc()
          ..add(
            VisitingScreenLoad(),
          ),
        child: App(store: store),
      ),
    ),
  );
}

class App extends StatefulWidget {
  final Store<AppState> store;
  const App({Key? key, required this.store}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeDataProvider>().isDarkMode;

    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        theme: isDarkMode ? _darkTheme : _lightTheme,
        debugShowCheckedModeBanner: false,
        title: AppString.places,
        home: const MainScreen(),
      ),
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
