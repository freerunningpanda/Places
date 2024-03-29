import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/want_to_visit/want_to_visit_bloc.dart';
import 'package:places/cubits/places_list/places_list_cubit.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/environment/environment.dart';
import 'package:places/providers/map_data_provider.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_card_size.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/place_card/place_card.dart';
import 'package:places/ui/widgets/add_new_place_button.dart';
import 'package:places/ui/widgets/error_widget.dart';
import 'package:places/ui/widgets/place_icons.dart';
import 'package:places/ui/widgets/search_bar.dart';

class PlaceListScreen extends StatefulWidget {
  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  State<PlaceListScreen> createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen> with TickerProviderStateMixin {
  final String envString = Environment.instance().buildConfig.envString;
  late final AnimationController _animationController;
  late final Animation<double> _rotateAnimation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _rotateAnimation = Tween<double>(begin: 0, end: -pi * 5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    _animationController
      ..forward()
      ..repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    final theme = Theme.of(context);
    final orientation = MediaQuery.of(context).orientation == Orientation.portrait;
    final isPortrait = context.read<PlacesListCubit>().isPortrait;
    final isSearchPage = context.read<PlacesListCubit>().isSearchPage;
    final readOnly = context.read<PlacesListCubit>().readOnly;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) => [
            SliverAppBar(
              automaticallyImplyLeading: false,
              centerTitle: orientation ? isPortrait : !isPortrait,
              pinned: true,
              title: Column(
                children: [
                  Text(
                    AppStrings.appTitle,
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    envString,
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ],
          body: BlocBuilder<PlacesListCubit, PlacesListState>(
            builder: (_, state) {
              if (state is PlacesListEmptyState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PlacesListLoadedState) {
                return Column(
                  children: [
                    if (orientation)
                      SearchBar(
                        isMainPage: true,
                        isSearchPage: isSearchPage,
                        readOnly: readOnly,
                        searchController: TextEditingController(),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: SearchBar(
                          isMainPage: true,
                          isSearchPage: isSearchPage,
                          readOnly: readOnly,
                          searchController: TextEditingController(),
                        ),
                      ),
                    if (orientation)
                      _PlaceListWidgetPortrait(
                        key: const PageStorageKey<String>('PlaceListScreen'),
                        placeList: state.places,
                        theme: theme,
                      )
                    else
                      _PlaceListWidgetLandscape(placeList: state.places, theme: theme),
                  ],
                );
              } else if (state is PlacesListErrorState) {
                return const ErrorWidget();
              } else {
                return Column(
                  children: [
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) => Transform.rotate(
                        angle: _rotateAnimation.value,
                        child: const PlaceIcons(
                          assetName: AppAssets.loader,
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const AddNewPlaceButton(),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _PlaceListWidgetPortrait extends StatefulWidget {
  final List<DbPlace> placeList;
  final ThemeData theme;

  const _PlaceListWidgetPortrait({
    Key? key,
    required this.placeList,
    required this.theme,
  }) : super(key: key);

  @override
  State<_PlaceListWidgetPortrait> createState() => _PlaceListWidgetPortraitState();
}

class _PlaceListWidgetPortraitState extends State<_PlaceListWidgetPortrait> {
  final interactor = PlaceInteractor(
    repository: PlaceRepository(
      apiPlaces: ApiPlaces(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final db = context.read<AppDb>();
    // Получить текущую позицию
    context.read<MapDataProvider>().getPosition();

    return Expanded(
      child: RefreshIndicator(
        color: AppColors.backgroundColor,
        backgroundColor: AppColors.transparent,
        onRefresh: () => context.read<PlacesListCubit>().getPlaces(),
        child: ListView.builder(
          key: const PageStorageKey<String>('SaveScrollPosition'),
          physics: Platform.isAndroid ? const ClampingScrollPhysics() : const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.placeList.length,
          itemBuilder: (_, index) {
            final place = widget.placeList[index];

            /// Из строки получаю список с картинками
            final urlsList = place.urls.split('|');
            final imageUrl = urlsList.isNotEmpty ? urlsList[0] : null;

            return Column(
              children: [
                FittedBox(
                  child: FutureBuilder(
                    future: getValue(db, place),
                    // ignore: avoid_types_on_closure_parameters
                    builder: (_, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        final isFavorite = snapshot.data ?? false;

                        return PlaceCard(
                          fromMapScreen: false,
                          fromMainScreen: true,
                          isMainScreen: true,
                          placeIndex: index,
                          isVisitingScreen: false,
                          aspectRatio: AppCardSize.placeCard,
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
                          addPlace: () => toggleFavorite(place),
                          url: imageUrl,
                          type: place.placeType,
                          name: place.name,
                          place: place,
                          details: [
                            Text(
                              place.name,
                              maxLines: 2,
                              style: widget.theme.textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 2),
                            SizedBox(
                              height: size.height / 7,
                              child: Text(
                                place.description,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.textText16Regular,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return PlaceCard(
                          fromMapScreen: false,
                          fromMainScreen: true,
                          isMainScreen: true,
                          placeIndex: index,
                          isVisitingScreen: false,
                          aspectRatio: AppCardSize.placeCard,
                          actionOne: const PlaceIcons(
                            assetName: AppAssets.favourite,
                            width: 22,
                            height: 22,
                          ),
                          url: imageUrl,
                          type: place.placeType,
                          name: place.name,
                          place: place,
                          details: [
                            Text(
                              place.name,
                              maxLines: 2,
                              style: widget.theme.textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 2),
                            SizedBox(
                              height: size.height / 7,
                              child: Text(
                                place.description,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.textText16Regular,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 11),
              ],
            );
          },
        ),
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
        interactor.addToFavorites(place: place, db: db, isVisited: false);
      } else {
        place.isFavorite = false;
        context.read<WantToVisitBloc>().add(
              RemoveFromWantToVisitEvent(
                db: db,
                isFavorite: place.isFavorite,
                place: place,
              ),
            );
        interactor.removeFromFavorites(place: place, db: db);
      }
    });
  }

  // Получить значение свойства isFavorite
  Future<bool> getValue(AppDb db, DbPlace place) async {
    final list = await db.favoritePlacesEntries;
    final isFavorite = list.any((p) => p.id == place.id);

    return isFavorite;
  }
}

class _PlaceListWidgetLandscape extends StatefulWidget {
  final List<DbPlace> placeList;
  final ThemeData theme;

  const _PlaceListWidgetLandscape({
    Key? key,
    required this.placeList,
    required this.theme,
  }) : super(key: key);

  @override
  State<_PlaceListWidgetLandscape> createState() => _PlaceListWidgetLandscapeState();
}

class _PlaceListWidgetLandscapeState extends State<_PlaceListWidgetLandscape> {
  final interactor = PlaceInteractor(
    repository: PlaceRepository(
      apiPlaces: ApiPlaces(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final db = context.read<AppDb>();

    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => context.read<PlacesListCubit>().getPlaces(),
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 1,
            crossAxisSpacing: 36,
            mainAxisExtent: 225,
          ),
          physics: Platform.isAndroid ? const ClampingScrollPhysics() : const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.placeList.length,
          itemBuilder: (_, index) {
            final place = widget.placeList[index];

            /// Из строки получаю список с картинками
            final urlsList = place.urls.split('|');
            final imageUrl = urlsList.isNotEmpty ? urlsList[0] : null;

            return Column(
              children: [
                FittedBox(
                  child: FutureBuilder(
                    future: getValue(db, place),
                    // ignore: avoid_types_on_closure_parameters
                    builder: (_, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        final isFavorite = snapshot.data ?? false;

                        return PlaceCard(
                          fromMapScreen: false,
                          fromMainScreen: true,
                          isMainScreen: true,
                          placeIndex: index,
                          isVisitingScreen: false,
                          aspectRatio: AppCardSize.placeCardLandscape,
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
                          addPlace: () => toggleFavorite(place),
                          url: imageUrl,
                          type: place.placeType,
                          name: place.name,
                          place: place,
                          details: [
                            Text(
                              place.name,
                              maxLines: 2,
                              style: widget.theme.textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 2),
                            SizedBox(
                              height: size.height / 7,
                              child: Text(
                                place.description,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.textText16Regular,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return PlaceCard(
                          fromMapScreen: false,
                          fromMainScreen: true,
                          isMainScreen: true,
                          placeIndex: index,
                          isVisitingScreen: false,
                          aspectRatio: AppCardSize.placeCardLandscape,
                          actionOne: const PlaceIcons(
                            assetName: AppAssets.favourite,
                            width: 22,
                            height: 22,
                          ),
                          url: imageUrl,
                          type: place.placeType,
                          name: place.name,
                          place: place,
                          details: [
                            Text(
                              place.name,
                              maxLines: 2,
                              style: widget.theme.textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 2),
                            SizedBox(
                              height: size.height / 7,
                              child: Text(
                                place.description,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.textText16Regular,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 11),
              ],
            );
          },
        ),
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
        interactor.addToFavorites(place: place, db: db, isVisited: false);
      } else {
        place.isFavorite = false;
        context.read<WantToVisitBloc>().add(
              RemoveFromWantToVisitEvent(
                db: db,
                isFavorite: place.isFavorite,
                place: place,
              ),
            );
        interactor.removeFromFavorites(place: place, db: db);
      }
    });
  }

  // Получить значение свойства isFavorite
  Future<bool> getValue(AppDb db, DbPlace place) async {
    final list = await db.favoritePlacesEntries;
    final isFavorite = list.any((p) => p.id == place.id);

    return isFavorite;
  }
}
