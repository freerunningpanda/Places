import 'dart:io';

import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/favorite/favorite_bloc.dart';
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
              centerTitle: orientation ? isPortrait : !isPortrait,
              pinned: true,
              title: Text(
                AppString.appTitle,
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
                      _PlaceListWidgetPortrait(placeList: state.places, theme: theme)
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
    _loadDb(db);

    return Expanded(
      child: ListView.builder(
        physics: Platform.isAndroid ? const ClampingScrollPhysics() : const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.placeList.length,
        itemBuilder: (_, index) {
          final place = widget.placeList[index];

          return Column(
            children: [
              FittedBox(
                child: PlaceCard(
                  placeIndex: index,
                  isVisitingScreen: false,
                  aspectRatio: AppCardSize.placeCard,
                  actionOne: BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (_, state) {
                      final isFavorite = place.isFavorite;

                      debugPrint('isFavoriteMain: $isFavorite place: ${place.name}');

                      if (state is IsFavoriteState) {
                        return isFavorite
                            ? const PlaceIcons(
                                assetName: AppAssets.heartFull,
                                width: 22,
                                height: 22,
                              )
                            : const PlaceIcons(
                                assetName: AppAssets.favourite,
                                width: 22,
                                height: 22,
                              );
                      } else if (state is IsNotFavoriteState) {
                        return isFavorite
                            ? const PlaceIcons(
                                assetName: AppAssets.heartFull,
                                width: 22,
                                height: 22,
                              )
                            : const PlaceIcons(
                                assetName: AppAssets.favourite,
                                width: 22,
                                height: 22,
                              );
                      } else {
                        throw ArgumentError('Bad state');
                      }
                    },
                  ),
                  url: place.urls[0],
                  type: place.placeType,
                  name: place.name,
                  placeList: widget.placeList,
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
                ),
              ),
              const SizedBox(height: 11),
            ],
          );
        },
      ),
    );
  }

  Future<void> _loadDb(AppDb db) async {
    await interactor.loadFavoritePlaces(db: db);
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
    _loadDb(db);

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

          return Column(
            children: [
              PlaceCard(
                placeIndex: index,
                isVisitingScreen: false,
                aspectRatio: 1.5 / 1,
                actionOne: BlocBuilder<FavoriteBloc, FavoriteState>(
                  builder: (_, state) {
                    final isFavorite = place.isFavorite;
                    if (state is IsFavoriteState) {
                      return isFavorite
                          ? const PlaceIcons(
                              assetName: AppAssets.heartFull,
                              width: 22,
                              height: 22,
                            )
                          : const PlaceIcons(
                              assetName: AppAssets.favourite,
                              width: 22,
                              height: 22,
                            );
                    } else if (state is IsNotFavoriteState) {
                      return isFavorite
                          ? const PlaceIcons(
                              assetName: AppAssets.heartFull,
                              width: 22,
                              height: 22,
                            )
                          : const PlaceIcons(
                              assetName: AppAssets.favourite,
                              width: 22,
                              height: 22,
                            );
                    } else {
                      return const Text('Bad state');
                    }
                  },
                ),
                url: place.urls[0],
                type: place.placeType,
                name: place.name,
                placeList: widget.placeList,
                details: [
                  Text(
                    place.name,
                    maxLines: 2,
                    style: widget.theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 2),
                  SizedBox(
                    height: size.height / 10,
                    child: Text(
                      place.description,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.textText16Regular,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 11),
            ],
          );
        },
      ),
    );
  }

  Future<void> _loadDb(AppDb db) async {
    await interactor.loadFavoritePlaces(db: db);
  }
}
