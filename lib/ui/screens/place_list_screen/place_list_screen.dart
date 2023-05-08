import 'dart:io';

import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/want_to_visit/want_to_visit_bloc.dart';
import 'package:places/cubits/places_list/places_list_cubit.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_card_size.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/place_card/place_card.dart';
import 'package:places/ui/widgets/add_new_place_button.dart';
import 'package:places/ui/widgets/error_widget.dart';
import 'package:places/ui/widgets/place_icons.dart';
import 'package:places/ui/widgets/search_bar.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({Key? key}) : super(key: key);

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
              title: Text(
                AppStrings.appTitle,
                style: theme.textTheme.titleLarge,
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
              }

              return const ErrorWidget();
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const AddNewPlaceButton(),
    );
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

    return Expanded(
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
        interactor.addToFavorites(place: place, db: db);
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
        interactor.addToFavorites(place: place, db: db);
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
