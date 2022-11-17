import 'dart:io';

import 'package:flutter/material.dart';

import 'package:places/data/sight.dart';
import 'package:places/mocks.dart';
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
  List<Sight> sightList = Mocks.mocks;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              centerTitle: MediaQuery.of(context).orientation == Orientation.portrait ? isPortrait : !isPortrait,
              pinned: true,
              title: Text(
                AppString.appTitle,
                style: theme.textTheme.titleLarge,
              ),
            ),
          ],
          body: Column(
            children: [
              if (MediaQuery.of(context).orientation == Orientation.portrait)
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
              if (MediaQuery.of(context).orientation == Orientation.portrait)
                _SightListWidgetPortrait(sightList: sightList, theme: theme)
              else
                _SightListWidgetLandscape(sightList: sightList, theme: theme),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const AddNewPlaceButton(),
    );
  }
}

class _SightListWidgetPortrait extends StatelessWidget {
  final List<Sight> sightList;
  final ThemeData theme;

  const _SightListWidgetPortrait({
    Key? key,
    required this.sightList,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: Platform.isAndroid ? const ClampingScrollPhysics() : const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: sightList.length,
        itemBuilder: (context, index) {
          final sight = sightList[index];

          return Column(
            children: [
              SightCard(
                isVisitingScreen: false,
                aspectRatio: 3 / 2,
                actionOne: const SightIcons(
                  assetName: AppAssets.favourite,
                  width: 22,
                  height: 22,
                ),
                url: sight.url ?? 'no_url',
                type: sight.type,
                name: sight.name,
                item: sight,
                details: [
                  Text(
                    sight.name,
                    maxLines: 2,
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    sight.details,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.textText16Regular,
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
  final List<Sight> sightList;
  final ThemeData theme;

  const _SightListWidgetLandscape({
    Key? key,
    required this.sightList,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        itemCount: sightList.length,
        itemBuilder: (context, index) {
          final sight = sightList[index];

          return Column(
            children: [
              SightCard(
                isVisitingScreen: false,
                aspectRatio: 3 / 1,
                actionOne: const SightIcons(
                  assetName: AppAssets.favourite,
                  width: 22,
                  height: 22,
                ),
                url: sight.url ?? 'no_url',
                type: sight.type,
                name: sight.name,
                item: sight,
                details: [
                  Text(
                    sight.name,
                    maxLines: 2,
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    sight.details,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.textText16Regular,
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
