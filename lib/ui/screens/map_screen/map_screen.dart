import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:places/blocs/want_to_visit/want_to_visit_bloc.dart';
import 'package:places/cubits/places_list/places_list_cubit.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/providers/theme_data_provider.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_card_size.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/place_card/place_card.dart';
import 'package:places/ui/widgets/add_new_place_button.dart';
import 'package:places/ui/widgets/place_icons.dart';
import 'package:places/ui/widgets/search_appbar.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final animation = const MapAnimation();
  late YandexMapController controller;
  GlobalKey mapKey = GlobalKey();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final isSearchPage = context.read<PlacesListCubit>().isSearchPage;
    final isDarkMode = context.read<ThemeDataProvider>().isDarkMode;
    final readOnly = context.read<PlacesListCubit>().readOnly;
    final themeData = context.read<ThemeDataProvider>();
    final cubit = context.read<PlacesListCubit>();
    final size = MediaQuery.of(context).size;
    final db = context.read<AppDb>();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const SearchAppBar(title: AppStrings.mapScreenTitle),
                const SizedBox(height: 16),
                SearchBar(
                  isMainPage: true,
                  isSearchPage: isSearchPage,
                  readOnly: readOnly,
                  searchController: TextEditingController(),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<PlacesListCubit, PlacesListState>(
              builder: (context, state) {
                return state is PlacesListLoadedState
                    ? Stack(
                        children: [
                          YandexMap(
                            key: mapKey,
                            onMapCreated: (yandexMapController) async {
                              controller = yandexMapController;
                            },
                            onUserLocationAdded: (view) async {
                              return view.copyWith(
                                pin: view.pin.copyWith(
                                  icon: PlacemarkIcon.single(PlacemarkIconStyle(
                                    image: BitmapDescriptor.fromAssetImage('lib/assets/user.png'),
                                  )),
                                ),
                                arrow: view.arrow.copyWith(
                                  icon: PlacemarkIcon.single(PlacemarkIconStyle(
                                    image: BitmapDescriptor.fromAssetImage('lib/assets/arrow.png'),
                                  )),
                                ),
                                accuracyCircle: view.accuracyCircle.copyWith(
                                  fillColor: Colors.green.withOpacity(0.5),
                                ),
                              );
                            },
                            mapObjects: state.places
                                .asMap()
                                .map(
                                  (i, place) {
                                    index = i;

                                    return MapEntry(
                                      index,
                                      PlacemarkMapObject(
                                        opacity: 1,
                                        icon: cubit.tappedPlacemark == place
                                            ? PlacemarkIcon.single(
                                                PlacemarkIconStyle(
                                                  scale: 3,
                                                  image: BitmapDescriptor.fromAssetImage(AppAssets.greenRound),
                                                ),
                                              )
                                            : PlacemarkIcon.single(
                                                PlacemarkIconStyle(
                                                  scale: 3,
                                                  image: themeData.isDarkMode
                                                      ? BitmapDescriptor.fromAssetImage(AppAssets.whiteRound)
                                                      : BitmapDescriptor.fromAssetImage(AppAssets.blueRound),
                                                ),
                                              ),
                                        mapId: MapObjectId(place.name),
                                        point: Point(
                                          latitude: place.lat,
                                          longitude: place.lng,
                                        ),
                                        onTap: (mapObject, point) async {
                                          debugPrint('${place.name} tapped');
                                          cubit.choosePlace(place);
                                        },
                                      ),
                                    );
                                  },
                                )
                                .values
                                .toList(),
                            nightModeEnabled: isDarkMode,
                          ),
                          if (cubit.tappedPlacemark != null)
                            Positioned(
                              bottom: 0,
                              left: 16,
                              right: 16,
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ActionWidget(
                                              assetName: AppAssets.refresh,
                                              onTap: () {},
                                            ),
                                            ActionWidget(
                                              assetName: AppAssets.geolocation,
                                              onTap: () async {
                                                // ignore: use_build_context_synchronously
                                                final mediaQuery = MediaQuery.of(context);
                                                final height =
                                                    mapKey.currentContext!.size!.height * mediaQuery.devicePixelRatio;
                                                final width =
                                                    mapKey.currentContext!.size!.width * mediaQuery.devicePixelRatio;

                                                await controller.toggleUserLayer(
                                                  visible: true,
                                                  autoZoomEnabled: true,
                                                  anchor: UserLocationAnchor(
                                                    course: Offset(width * 0.5, height * 0.5),
                                                    normal: Offset(width * 0.5, height * 0.5),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 16.0),
                                        child: AspectRatio(
                                          aspectRatio: AppCardSize.previewCard,
                                          child: FutureBuilder(
                                            future: getValue(
                                              db,
                                              state.tappedPlacemark ??
                                                  DbPlace(
                                                    id: 0,
                                                    lat: 0,
                                                    lng: 0,
                                                    name: 'null',
                                                    urls: 'null',
                                                    placeType: 'null',
                                                    description: 'null',
                                                  ),
                                            ),
                                            // ignore: avoid_types_on_closure_parameters
                                            builder: (_, AsyncSnapshot<bool> snapshot) {
                                              if (snapshot.connectionState == ConnectionState.done) {
                                                final isFavorite = snapshot.data ?? false;

                                                return PlaceCard(
                                                  fromMainScreen: false,
                                                  url: cubit.tappedPlacemark?.urls,
                                                  type: cubit.tappedPlacemark!.placeType,
                                                  name: cubit.tappedPlacemark!.name,
                                                  details: [
                                                    Text(
                                                      cubit.tappedPlacemark!.name,
                                                      maxLines: 2,
                                                    ),
                                                    const SizedBox(height: 2),
                                                    SizedBox(
                                                      width: size.width * 0.5,
                                                      child: Text(
                                                        cubit.tappedPlacemark!.description,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: AppTypography.textText16Regular,
                                                      ),
                                                    ),
                                                  ],
                                                  actionOne: isFavorite
                                                      ? const PlaceIcons(
                                                          assetName: AppAssets.heartFull,
                                                          width: 22,
                                                          height: 22,
                                                        )
                                                      : const PlaceIcons(
                                                          assetName: AppAssets.favourite,
                                                          width: 22,
                                                          height: 22,
                                                        ),
                                                  addPlace: () => toggleFavorite(
                                                    state.tappedPlacemark ??
                                                        DbPlace(
                                                          id: 0,
                                                          lat: 0,
                                                          lng: 0,
                                                          name: 'null',
                                                          urls: 'null',
                                                          placeType: 'null',
                                                          description: 'null',
                                                        ),
                                                  ),
                                                  aspectRatio: AppCardSize.visitingCard,
                                                  place: cubit.tappedPlacemark!,
                                                  placeIndex: index,
                                                  isVisitingScreen: false,
                                                  isMainScreen: false,
                                                );
                                              } else {
                                                return PlaceCard(
                                                  fromMainScreen: false,
                                                  url: cubit.tappedPlacemark?.urls,
                                                  type: cubit.tappedPlacemark!.placeType,
                                                  name: cubit.tappedPlacemark!.name,
                                                  details: [
                                                    Text(
                                                      cubit.tappedPlacemark!.name,
                                                      maxLines: 2,
                                                    ),
                                                    const SizedBox(height: 2),
                                                    SizedBox(
                                                      width: size.width * 0.5,
                                                      child: Text(
                                                        cubit.tappedPlacemark!.description,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: AppTypography.textText16Regular,
                                                      ),
                                                    ),
                                                  ],
                                                  actionOne: const PlaceIcons(
                                                    assetName: AppAssets.favourite,
                                                    width: 22,
                                                    height: 22,
                                                  ),
                                                  aspectRatio: AppCardSize.visitingCard,
                                                  place: cubit.tappedPlacemark!,
                                                  placeIndex: index,
                                                  isVisitingScreen: false,
                                                  isMainScreen: false,
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    right: 16,
                                    bottom: 30,
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: InkWell(
                                        onTap: () => debugPrint('route tapped'),
                                        child: const PlaceIcons(
                                          assetName: AppAssets.route,
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<PlacesListCubit, PlacesListState>(
        builder: (context, state) {
          // ignore: use_build_context_synchronously
          return state is PlacesListLoadedState
              ? Visibility(
                  visible: cubit.isAddPlaceBtnVisible,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    ActionWidget(assetName: AppAssets.refresh, onTap: () {}),
                    const AddNewPlaceButton(),
                    ActionWidget(
                      assetName: AppAssets.geolocation,
                      onTap: () async {
                        // ignore: use_build_context_synchronously
                        final mediaQuery = MediaQuery.of(context);
                        final height = mapKey.currentContext!.size!.height * mediaQuery.devicePixelRatio;
                        final width = mapKey.currentContext!.size!.width * mediaQuery.devicePixelRatio;
                        await controller.toggleUserLayer(
                          visible: true,
                          autoZoomEnabled: true,
                          anchor: UserLocationAnchor(
                            course: Offset(width * 0.5, height * 0.5),
                            normal: Offset(width * 0.5, height * 0.5),
                          ),
                        );
                      },
                    ),
                  ]),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<void> toggleFavorite(DbPlace place) async {
    final db = context.read<AppDb>();
    final isFavorite = await getValue(db, place);
    setState(() {
      if (!isFavorite) {
        place.isFavorite = true;
        context.read<WantToVisitBloc>().add(
              AddToWantToVisitEvent(
                db: db,
                isFavorite: place.isFavorite,
                place: place,
              ),
            );
        db.addPlace(place, isSearchScreen: false);
      } else {
        place.isFavorite = false;
        context.read<WantToVisitBloc>().add(
              RemoveFromWantToVisitEvent(
                db: db,
                isFavorite: place.isFavorite,
                place: place,
              ),
            );
        db.deletePlace(place);
      }
    });
  }

  void removeFromFavorites(DbPlace place) {
    final db = context.read<AppDb>();

    setState(() {
      place.isFavorite = false;
      PlaceInteractor.favoritePlaces.remove(place);
      db.deletePlace(place);
    });
  }

  // Получить значение свойства isFavorite
  Future<bool> getValue(AppDb db, DbPlace place) async {
    final list = await db.favoritePlacesEntries;
    final isFavorite = list.any((p) => p.id == place.id);

    return isFavorite;
  }

  void _showMessage(BuildContext context, Text text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: text));
  }
}

class ActionWidget extends StatelessWidget {
  final String assetName;
  final VoidCallback onTap;
  const ActionWidget({
    Key? key,
    required this.assetName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: theme.tabBarTheme.labelColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: PlaceIcons(
              assetName: assetName,
              width: 24,
              height: 24,
              color: theme.disabledColor,
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
