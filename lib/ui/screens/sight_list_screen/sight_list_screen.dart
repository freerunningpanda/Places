import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/favorite/favorite_bloc.dart';
import 'package:places/cubits/places_list/places_list_cubit.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/sight_card/sight_card.dart';
import 'package:places/ui/widgets/add_new_place_button.dart';
import 'package:places/ui/widgets/error_widget.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:places/ui/widgets/sight_icons.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  final bool readOnly = true;
  final isEnabled = true;
  final isSearchPage = false;
  final isPortrait = true;
  final _controller = StreamController<List<Place>>();
  late List<Place> placeList;

  @override
  void initState() {
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

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
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
                        isSearchPage: isSearchPage,
                        readOnly: readOnly,
                        searchController: TextEditingController(),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: SearchBar(
                          isSearchPage: isSearchPage,
                          readOnly: readOnly,
                          searchController: TextEditingController(),
                        ),
                      ),
                    if (orientation)
                      _SightListWidgetPortrait(placeList: state.places, theme: theme)
                    else
                      _SightListWidgetLandscape(placeList: state.places, theme: theme),
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

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }
}

class _SightListWidgetPortrait extends StatefulWidget {
  final List<Place> placeList;
  final ThemeData theme;

  const _SightListWidgetPortrait({
    Key? key,
    required this.placeList,
    required this.theme,
  }) : super(key: key);

  @override
  State<_SightListWidgetPortrait> createState() => _SightListWidgetPortraitState();
}

class _SightListWidgetPortraitState extends State<_SightListWidgetPortrait> {
  final _controller = StreamController<bool>.broadcast();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Expanded(
      child: ListView.builder(
        physics: Platform.isAndroid ? const ClampingScrollPhysics() : const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.placeList.length,
        itemBuilder: (context, index) {
          final place = widget.placeList[index];

          return Column(
            children: [
              FittedBox(
                child: SightCard(
                  placeIndex: index,
                  isVisitingScreen: false,
                  aspectRatio: 3 / 2,
                  actionOne: BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, state) {
                      if (state is IsFavoriteState) {
                        return place.isFavorite
                            ? const SightIcons(
                                assetName: AppAssets.heartFull,
                                width: 22,
                                height: 22,
                              )
                            : const SightIcons(
                                assetName: AppAssets.favourite,
                                width: 22,
                                height: 22,
                              );
                      } else if (state is IsNotFavoriteState) {
                        return place.isFavorite
                            ? const SightIcons(
                                assetName: AppAssets.heartFull,
                                width: 22,
                                height: 22,
                              )
                            : const SightIcons(
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

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}

class _SightListWidgetLandscape extends StatelessWidget {
  final List<Place> placeList;
  final ThemeData theme;

  const _SightListWidgetLandscape({
    Key? key,
    required this.placeList,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
        itemCount: placeList.length,
        itemBuilder: (context, index) {
          final place = placeList[index];

          return Column(
            children: [
              SightCard(
                placeIndex: index,
                isVisitingScreen: false,
                aspectRatio: 1.5 / 1,
                actionOne: const SightIcons(
                  assetName: AppAssets.favourite,
                  width: 22,
                  height: 22,
                ),
                url: place.urls[0],
                type: place.placeType,
                name: place.name,
                placeList: placeList,
                details: [
                  Text(
                    place.name,
                    maxLines: 2,
                    style: theme.textTheme.headlineSmall,
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
}
