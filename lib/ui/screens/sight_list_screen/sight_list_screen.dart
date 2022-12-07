import 'dart:io';

import 'package:flutter/material.dart';

import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/api_place_repository.dart';
import 'package:places/domain/place_ui.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/sight_card/sight_card.dart';
import 'package:places/ui/widgets/add_new_place_button.dart';
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
  late List<PlaceUI> placeList;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getPlaces();
  }

  @override
  Widget build(BuildContext context) {
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
          body: isLoading
              ? Column(
                  children: [
                    if (orientation)
                      SearchBar(
                        isSearchPage: isSearchPage,
                        readOnly: readOnly,
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: SearchBar(
                          isSearchPage: isSearchPage,
                          readOnly: readOnly,
                        ),
                      ),
                    if (orientation)
                      _SightListWidgetPortrait(placeList: placeList, theme: theme)
                    else
                      _SightListWidgetLandscape(placeList: placeList, theme: theme),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const AddNewPlaceButton(),
    );
  }

  Future<void> getPlaces() async {
    placeList = await PlaceInteractor(apiPlaceRepository: ApiPlaceRepository()).getPlaces();
    setState(() {
      isLoading = true;
    });
  }
}

class _SightListWidgetPortrait extends StatelessWidget {
  final List<PlaceUI> placeList;
  final ThemeData theme;

  const _SightListWidgetPortrait({
    Key? key,
    required this.placeList,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Expanded(
      child: ListView.builder(
        physics: Platform.isAndroid ? const ClampingScrollPhysics() : const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: placeList.length,
        itemBuilder: (context, index) {
          final place = placeList[index];

          return Column(
            children: [
              SightCard(
                addSight: () {
                  debugPrint('🟡---------like pressed');
                },
                isVisitingScreen: false,
                aspectRatio: 3 / 2,
                actionOne: const SightIcons(
                  assetName: AppAssets.favourite,
                  width: 22,
                  height: 22,
                ),
                url: place.urls[0],
                type: place.placeType,
                name: place.name,
                item: place,
                details: [
                  Text(
                    place.name,
                    maxLines: 2,
                    style: theme.textTheme.headlineSmall,
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
              const SizedBox(height: 11),
            ],
          );
        },
      ),
    );
  }
}

class _SightListWidgetLandscape extends StatelessWidget {
  final List<PlaceUI> placeList;
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
                item: place,
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
