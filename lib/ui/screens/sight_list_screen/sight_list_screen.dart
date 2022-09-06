import 'package:flutter/material.dart';

import 'package:places/data/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/sight_card/sight_card.dart';
import 'package:places/ui/widgets/add_new_place_button.dart';
import 'package:places/ui/widgets/search_widget.dart';
import 'package:places/ui/widgets/sight_icons.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  List<Sight> sightList = Mocks.mocks;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 64),
              const _AppBar(),
              SearchWidget(sightList: sightList),
              _SightListWidget(sightList: sightList, theme: theme),
            ],
          ),
          const Positioned(
            bottom: 16,
            left: 92,
            right: 92,
            child: AddNewPlaceButton(),
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const _AppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 86,
      title: const Text(
        AppString.appTitle,
      ),
      bottomOpacity: 0.0,
    );
  }
}

class _SightListWidget extends StatelessWidget {
  final List<Sight> sightList;
  final ThemeData theme;

  const _SightListWidget({
    Key? key,
    required this.sightList,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: sightList.length,
        itemBuilder: (context, index) {
          final sight = sightList[index];

          return SightCard(
            isVisitingScreen: false,
            aspectRatio: 3 / 2,
            actionOne: const SightIcons(
              assetName: AppAssets.favourite,
              width: 22,
              height: 22,
            ),
            url: sight.url,
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
          );
        },
      ),
    );
  }
}
