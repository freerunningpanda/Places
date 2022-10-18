import 'package:flutter/material.dart';

import 'package:places/appsettings.dart';
import 'package:places/data/sight.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_card_size.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/res/custom_colors.dart';
import 'package:places/ui/screens/sight_card/sight_card.dart';
import 'package:places/ui/widgets/add_new_place_button.dart';
import 'package:places/ui/widgets/sight_icons.dart';
import 'package:provider/provider.dart';

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final sightsToVisit = context.watch<AppSettings>().sightsToVisit;
    final visitedSights = context.watch<AppSettings>().visitedSights;

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: const _AppBar(),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: TabBarView(
                    children: [
                      if (sightsToVisit.isNotEmpty)
                        _WantToVisitWidget(
                          sightsToVisit: sightsToVisit,
                          key: const PageStorageKey('WantToVisitScrollPosition'),
                        )
                      else
                        const _EmptyList(
                          icon: AppAssets.card,
                          description: AppString.likedPlaces,
                        ),
                      if (visitedSights.isNotEmpty)
                        _VisitedWidget(
                          visitedSights: visitedSights,
                          key: const PageStorageKey('VisitedScrollPosition'),
                        )
                      else
                        const _EmptyList(
                          icon: AppAssets.goIconTransparent,
                          description: AppString.finishRoute,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: const AddNewPlaceButton(),
        ),
      ),
    );
  }
}

class _AppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(150);

  const _AppBar({Key? key}) : super(key: key);

  @override
  State<_AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<_AppBar> with TickerProviderStateMixin {
  final aligment = Alignment.center;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        AppString.visitingScreenTitle,
        style: theme.textTheme.titleLarge,
      ),
      elevation: 0,
      bottom: const _TabBarWidget(),
    );
  }
}

class _TabBarWidget extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(150);
  const _TabBarWidget({Key? key}) : super(key: key);

  @override
  State<_TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<_TabBarWidget> with TickerProviderStateMixin {
  final aligment = Alignment.center;

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>();

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: customColors?.color,
      ),
      child: const TabBar(
        tabs: [
          Tab(
            child: Text(
              AppString.tabBarOneText,
            ),
          ),
          Tab(
            child: Text(
              AppString.tabBarTwoText,
            ),
          ),
        ],
      ),
    );
  }
}

class _WantToVisitWidget extends StatelessWidget {
  final List<Sight> sightsToVisit;
  const _WantToVisitWidget({Key? key, required this.sightsToVisit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) newIndex--;
        context.read<AppSettings>().dragCard(sightsToVisit, oldIndex, newIndex);
      },
      children: [
        for (var i = 0; i < sightsToVisit.length; i++)
          ClipRRect(
            key: ObjectKey(sightsToVisit[i]),
            borderRadius: BorderRadius.circular(16.0),
            child: _DismissibleWidget(
              i: i,
              sightsToVisit: sightsToVisit,
              theme: theme,
              uniqueKey: UniqueKey(),
              actionTwo: const SightIcons(
                assetName: AppAssets.cross,
                width: 22,
                height: 22,
              ),
              style: AppTypography.greenColor,
              target: AppString.planning,
            ),
          ),
      ],
    );
  }
}

class _VisitedWidget extends StatelessWidget {
  final List<Sight> visitedSights;
  const _VisitedWidget({Key? key, required this.visitedSights}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) newIndex--;
        context.read<AppSettings>().dragCard(visitedSights, oldIndex, newIndex);
      },
      children: [
        for (var i = 0; i < visitedSights.length; i++)
          _DismissibleWidget(
            key: ObjectKey(visitedSights[i]),
            i: i,
            sightsToVisit: visitedSights,
            theme: theme,
            uniqueKey: UniqueKey(),
            actionTwo: const SightIcons(
              assetName: AppAssets.share,
              width: 22,
              height: 22,
            ),
            style: AppTypography.detailsText,
            target: AppString.targetReach,
          ),
      ],
    );
  }
}

class _DismissibleWidget extends StatelessWidget {
  final int i;
  final List<Sight> sightsToVisit;
  final ThemeData theme;
  final Key uniqueKey;
  final Widget actionTwo;
  final String target;
  final TextStyle style;

  const _DismissibleWidget({
    Key? key,
    required this.i,
    required this.sightsToVisit,
    required this.theme,
    required this.uniqueKey,
    required this.actionTwo,
    required this.style,
    required this.target,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: AppCardSize.visitingCard,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.red,
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      // ignore: avoid_redundant_argument_values
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SightIcons(assetName: AppAssets.bucket, width: 24, height: 24),
                        SizedBox(height: 8),
                        Text(
                          AppString.delete,
                          style: AppTypography.removeCardText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Dismissible(
          key: uniqueKey,
          onDismissed: (direction) => context.read<AppSettings>().deleteSight(i, sightsToVisit),
          background: const SizedBox.shrink(),
          direction: DismissDirection.endToStart,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 11.0),
            child: SightCard(
              removeSight: () => context.read<AppSettings>().deleteSight(i, sightsToVisit),
              isVisitingScreen: true,
              item: sightsToVisit[i],
              url: sightsToVisit[i].url ?? 'no_url',
              type: sightsToVisit[i].type,
              name: sightsToVisit[i].name,
              aspectRatio: AppCardSize.visitingCard,
              details: [
                Text(
                  sightsToVisit[i].name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 2),
                Text(
                  '$target 12 окт. 2022',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: style,
                ),
                const SizedBox(height: 10),
                const Text(
                  '${AppString.closed} 09:00',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.textText16Regular,
                ),
              ],
              actionOne: const SightIcons(
                assetName: AppAssets.calendarWhite,
                width: 24,
                height: 24,
              ),
              actionTwo: actionTwo,
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyList extends StatelessWidget {
  final String icon;
  final String description;
  const _EmptyList({
    Key? key,
    required this.icon,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SightIcons(
          assetName: icon,
          width: 64,
          height: 64,
        ),
        const SizedBox(height: 24),
        const Text(
          AppString.emptyList,
          style: AppTypography.emptyListTitle,
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 190,
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: AppTypography.emptyListSubTitle,
          ),
        ),
      ],
    );
  }
}
