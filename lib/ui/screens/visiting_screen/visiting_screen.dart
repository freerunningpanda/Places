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

class _VisitingScreenState extends State<VisitingScreen> {
  int initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    final sightsToVisit = context.watch<AppSettings>().sightsToVisit;
    final visitedSights = context.watch<AppSettings>().visitedSights;

    return DefaultTabController(
      length: 2,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: const _AppBar(),
        body: Stack(
          children: [
            Column(
              children: [
                const _TabBarWidget(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: TabBarView(
                      children: [
                        if (sightsToVisit.isNotEmpty)
                          Draggable(
                            feedback: const SizedBox.shrink(),
                            child: _WantToVisitWidget(
                              sightsToVisit: sightsToVisit,
                              key: const PageStorageKey('WantToVisitScrollPosition'),
                            ),
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
            const Positioned(
              bottom: 16,
              left: 92,
              right: 92,
              child: AddNewPlaceButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(45);

  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      centerTitle: true,
      title: Text(
        AppString.visitingScreenTitle,
        style: theme.textTheme.titleLarge,
      ),
      elevation: 0,
    );
  }
}

class _TabBarWidget extends StatelessWidget {
  const _TabBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>();
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: customColors?.color,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        clipBehavior: Clip.antiAlias,
        type: MaterialType.transparency,
        child: TabBar(
          onTap: (value) {
            debugPrint('🟡---------TabBar pressed: $value');
          },
          unselectedLabelColor: Colors.grey,
          labelColor: theme.toggleableActiveColor,
          labelStyle: AppTypography.tabBarIndicator,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: theme.iconTheme.color,
          ),
          tabs: const [
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
          Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) => context.read<AppSettings>().deleteSight(i, sightsToVisit),
            background: const SizedBox.shrink(),
            secondaryBackground: AspectRatio(
              aspectRatio: AppCardSize.visitingCard,
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                width: double.infinity,
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
                        children: const[
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
            direction: DismissDirection.endToStart,
            child: SightCard(
              key: ValueKey(i),
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
                  maxLines: 2,
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 2),
                const Text(
                  '${AppString.planning} 12 окт. 2022',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.greenColor,
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
              actionTwo: const SightIcons(
                assetName: AppAssets.cross,
                width: 22,
                height: 22,
              ),
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
          Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) => context.read<AppSettings>().deleteSight(i, visitedSights),
            background: const SizedBox.shrink(),
            secondaryBackground: AspectRatio(
              aspectRatio: AppCardSize.visitingCard,
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                width: double.infinity,
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
                        children: const[
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
            direction: DismissDirection.endToStart,
            child: SightCard(
              key: ValueKey(i),
              removeSight: () => context.read<AppSettings>().deleteSight(i, visitedSights),
              isVisitingScreen: true,
              item: visitedSights[i],
              url: visitedSights[i].url ?? 'no_url',
              type: visitedSights[i].type,
              name: visitedSights[i].name,
              aspectRatio: AppCardSize.visitingCard,
              details: [
                Text(
                  visitedSights[i].name,
                  maxLines: 2,
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 2),
                const Text(
                  '${AppString.planning} 12 окт. 2022',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.detailsText,
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
              actionTwo: const SightIcons(
                assetName: AppAssets.share,
                width: 22,
                height: 22,
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
