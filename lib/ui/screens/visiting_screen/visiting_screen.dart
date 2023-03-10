import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/favorite/favorite_bloc.dart';
import 'package:places/blocs/visited/visited_screen_bloc.dart';
import 'package:places/blocs/want_to_visit/want_to_visit_bloc.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_card_size.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/place_card/place_card.dart';
import 'package:places/ui/screens/res/custom_colors.dart';
import 'package:places/ui/widgets/add_new_place_button.dart';
import 'package:places/ui/widgets/place_icons.dart';

class VisitingScreen extends StatelessWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
                      BlocBuilder<WantToVisitBloc, WantToVisitScreenState>(
                        builder: (_, state) {
                          if (state is WantToVisitScreenEmptyState) {
                            return const _EmptyList(
                              icon: AppAssets.card,
                              description: AppString.likedPlaces,
                            );
                          }
                          if (state is WantToVisitScreenIsNotEmpty) {
                            // Места могут быть удалены из избранного
                            // В этом случае показываем опять пустое состояние экрана
                            if (state.favoritePlaces.isEmpty) {
                              return const _EmptyList(
                                icon: AppAssets.card,
                                description: AppString.likedPlaces,
                              );
                            }
                            debugPrint('Места (BlocBuilder): ${state.favoritePlaces}');

                            return _WantToVisitWidget(
                              placesToVisit: state.favoritePlaces.toList(),
                              key: const PageStorageKey('WantToVisitScrollPosition'),
                            );
                          }
                          if (state is WantToVisitAfterDragState) {
                            return _WantToVisitWidget(
                              placesToVisit: state.favoritePlaces,
                              key: const PageStorageKey('WantToVisitScrollPosition'),
                            );
                          }
                          throw ArgumentError('Bad State');
                        },
                      ),
                      BlocBuilder<VisitedScreenBloc, VisitedScreenState>(
                        builder: (_, state) {
                          if (state is VisitedEmptyState) {
                            return const _EmptyList(
                              icon: AppAssets.goIconTransparent,
                              description: AppString.finishRoute,
                            );
                          }
                          if (state is VisitedIsNotEmpty) {
                            return state.visitedPlaces.isEmpty
                                ? const _EmptyList(
                                    icon: AppAssets.goIconTransparent,
                                    description: AppString.finishRoute,
                                  )
                                : _VisitedWidget(
                                    visitedPlaces: state.visitedPlaces.toList(),
                                    key: const PageStorageKey('VisitedScrollPosition'),
                                  );
                          }
                          throw ArgumentError('Error');
                        },
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
  final List<Place> placesToVisit;
  const _WantToVisitWidget({Key? key, required this.placesToVisit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        context.read<WantToVisitBloc>().add(
              DragCardOnWantToVisitEvent(
                newIndex: newIndex,
                oldIndex: oldIndex,
                places: placesToVisit,
              ),
            );
      },
      children: [
        for (var i = 0; i < placesToVisit.length; i++)
          ClipRRect(
            key: ObjectKey(placesToVisit[i]),
            borderRadius: BorderRadius.circular(16.0),
            child: _DismissibleWidget(
              i: i,
              placesToVisit: placesToVisit,
              theme: theme,
              uniqueKey: UniqueKey(),
              actionTwo: const PlaceIcons(
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
  final List<Place> visitedPlaces;
  const _VisitedWidget({Key? key, required this.visitedPlaces}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        context.read<VisitedScreenBloc>().add(
              DragCardOnVisitedEvent(
                newIndex: newIndex,
                oldIndex: oldIndex,
                places: visitedPlaces,
              ),
            );
      },
      children: [
        for (var i = 0; i < visitedPlaces.length; i++)
          _DismissibleWidget(
            i: i,
            placesToVisit: visitedPlaces,
            theme: theme,
            uniqueKey: UniqueKey(),
            actionTwo: const PlaceIcons(
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
  final List<Place> placesToVisit;
  final ThemeData theme;
  final Key uniqueKey;
  final Widget actionTwo;
  final String target;
  final TextStyle style;

  const _DismissibleWidget({
    Key? key,
    required this.i,
    required this.placesToVisit,
    required this.theme,
    required this.uniqueKey,
    required this.actionTwo,
    required this.style,
    required this.target,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation == Orientation.portrait;

    return Stack(
      children: [
        AspectRatio(
          aspectRatio: orientation ? AppCardSize.visitingCardDismiss : AppCardSize.visitingCardDismissLandscape,
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
                        PlaceIcons(assetName: AppAssets.bucket, width: 24, height: 24),
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
        AspectRatio(
          aspectRatio: orientation ? AppCardSize.visitingCard : AppCardSize.visitingCardLandscape,
          child: Dismissible(
            key: uniqueKey,
            onDismissed: (direction) {
              // Отправляю в эвент удаления карточки id свойство текущего места, само место
              // и меняю свойство isFavorite на false
              // Благодаря чему стейт видит обновление состояния и теперь виджет перерисовывается
              // P.S.: раньше не обновлялся UI при попытке удалить карточку из-за того что
              // Я отправлял в эвент только индекс элемента в списке (а не индекс свойства места) и список избранного,
              // Из-за чего блок не видел смены состояния, из-за особенности Equatable,
              // который не видит изменений если количество элементов в списке изменилось
              // так список для него иммутабелен,
              // а сейчас я добавил флаг isFavorite
              // И передаю в эвент само место в избранном, а не весь список избранного
              context.read<WantToVisitBloc>().add(
                    RemoveFromWantToVisitEvent(
                      isFavorite: placesToVisit[i].isFavorite = false,
                      place: placesToVisit[i],
                      placeIndex: placesToVisit[i].id,
                    ),
                  );
              context.read<FavoriteBloc>().add(
                    FavoriteEvent(
                      isFavorite: placesToVisit[i].isFavorite = false,
                      place: placesToVisit[i],
                      placeIndex: placesToVisit[i].id,
                    ),
                  );
            },
            background: const SizedBox.shrink(),
            direction: DismissDirection.endToStart,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 11.0),
              child: PlaceCard(
                placeIndex: i,
                removePlace: () {
                  context.read<WantToVisitBloc>().add(
                        RemoveFromWantToVisitEvent(
                          isFavorite: placesToVisit[i].isFavorite = false,
                          place: placesToVisit[i],
                          placeIndex: i,
                        ),
                      );
                  context.read<FavoriteBloc>().add(
                        FavoriteEvent(
                          isFavorite: placesToVisit[i].isFavorite = false,
                          place: placesToVisit[i],
                          placeIndex: i,
                        ),
                      );
                },
                isVisitingScreen: true,
                placeList: placesToVisit,
                url: placesToVisit[i].urls[0],
                type: placesToVisit[i].placeType,
                name: placesToVisit[i].name,
                aspectRatio: AppCardSize.visitingCardDismiss,
                details: [
                  Text(
                    placesToVisit[i].name,
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
                actionOne: const PlaceIcons(
                  assetName: AppAssets.calendarWhite,
                  width: 24,
                  height: 24,
                ),
                actionTwo: actionTwo,
              ),
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
        PlaceIcons(
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
