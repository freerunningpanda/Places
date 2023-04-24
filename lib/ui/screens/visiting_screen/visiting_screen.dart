import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/favorite/favorite_bloc.dart';
import 'package:places/blocs/visited/visited_screen_bloc.dart';
import 'package:places/blocs/want_to_visit/want_to_visit_bloc.dart';
import 'package:places/data/database/database.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_card_size.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/place_card/place_card.dart';
import 'package:places/ui/screens/res/custom_colors.dart';
import 'package:places/ui/widgets/add_new_place_button.dart';
import 'package:places/ui/widgets/place_icons.dart';

bool fromVisitingScreen = false;

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
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
                            debugPrint('placesToVisit: emptyState');

                            return const _EmptyList(
                              icon: AppAssets.card,
                              description: AppStrings.likedPlaces,
                            );
                          }
                          if (state is WantToVisitScreenIsNotEmpty) {
                            // Места могут быть удалены из избранного
                            // В этом случае показываем опять пустое состояние экрана
                            if (state.favoritePlaces.isEmpty) {
                              debugPrint('placesToVisit: ${state.favoritePlaces.length}');

                              return const _EmptyList(
                                icon: AppAssets.card,
                                description: AppStrings.likedPlaces,
                              );
                            }
                            debugPrint('Места (BlocBuilder): ${state.favoritePlaces}');
                            debugPrint('placesToVisit: ${state.favoritePlaces.length}');

                            return _WantToVisitWidget(
                              placesToVisit: state.favoritePlaces.toList(),
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
                              description: AppStrings.finishRoute,
                            );
                          }
                          if (state is VisitedIsNotEmpty) {
                            return const _VisitedWidget(
                              key: PageStorageKey('VisitedScrollPosition'),
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
        AppStrings.visitingScreenTitle,
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
              AppStrings.tabBarOneText,
            ),
          ),
          Tab(
            child: Text(
              AppStrings.tabBarTwoText,
            ),
          ),
        ],
      ),
    );
  }
}

class _WantToVisitWidget extends StatefulWidget {
  final List<DbPlace> placesToVisit;
  const _WantToVisitWidget({Key? key, required this.placesToVisit}) : super(key: key);

  @override
  State<_WantToVisitWidget> createState() => _WantToVisitWidgetState();
}

class _WantToVisitWidgetState extends State<_WantToVisitWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final db = context.read<AppDb>();
    final orientation = MediaQuery.of(context).orientation == Orientation.portrait;

    return FutureBuilder(
      future: context.read<WantToVisitBloc>().getPlaces(db),
      // ignore: avoid_types_on_closure_parameters
      builder: (_, AsyncSnapshot<List<DbPlace>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final favoritePlaces = snapshot.data;

          return ReorderableListView.builder(
            onReorder: (oldIndex, newIndex) async {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              final place = favoritePlaces!.removeAt(oldIndex);
              favoritePlaces.insert(newIndex, place);
              for (var i = 0; i < favoritePlaces.length; i++) {
                final updatedPlace = favoritePlaces[i].copyWith(index: Value<int>(i));
                await db.updatePlace(updatedPlace);
              }
            },
            itemCount: favoritePlaces!.length,
            itemBuilder: (_, index) {
              final place = favoritePlaces[index];

              return _DismissibleWidget(
                key: ObjectKey(index),
                index: index,
                orientation: orientation,
                place: place,
                db: db,
                theme: theme,
                actionTwo: const PlaceIcons(
                  assetName: AppAssets.cross,
                  width: 22,
                  height: 22,
                ),
                style: AppTypography.greenColor,
                target: AppStrings.planning,
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class _DismissibleWidget extends StatelessWidget {
  final int index;
  final bool orientation;
  final DbPlace place;
  final AppDb db;
  final ThemeData theme;
  final TextStyle style;
  final Widget actionTwo;
  final String target;

  const _DismissibleWidget({
    Key? key,
    required this.index,
    required this.orientation,
    required this.place,
    required this.db,
    required this.theme,
    required this.style,
    required this.actionTwo,
    required this.target,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: orientation ? AppCardSize.visitingCard : AppCardSize.visitingCardLandscape,
      child: Stack(
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
                            AppStrings.delete,
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
              key: ObjectKey(index),
              onDismissed: (direction) async {
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
                place.isFavorite = false;
                context.read<WantToVisitBloc>().add(
                      RemoveFromWantToVisitEvent(
                        db: db,
                        isFavorite: place.isFavorite,
                        place: place,
                      ),
                    );
                place.isFavorite = false;
                context.read<FavoriteBloc>().add(
                      RemoveFromFavoriteEvent(
                        db: db,
                        isFavorite: place.isFavorite,
                        place: place,
                        placeIndex: place.id,
                      ),
                    );
                fromVisitingScreen = true;
                debugPrint('placesToVisit[i].id: ${place.id}');
              },
              background: const SizedBox.shrink(),
              direction: DismissDirection.endToStart,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 11.0),
                child: PlaceCard(
                  placeIndex: place.id,
                  actionThree: () async {
                    debugPrint('pressed_remove_place');
                    place.isFavorite = false;
                    context.read<WantToVisitBloc>().add(
                          RemoveFromWantToVisitEvent(
                            db: db,
                            isFavorite: place.isFavorite,
                            place: place,
                          ),
                        );
                    place.isFavorite = false;
                    context.read<FavoriteBloc>().add(
                          RemoveFromFavoriteEvent(
                            db: db,
                            isFavorite: place.isFavorite,
                            place: place,
                            placeIndex: place.id,
                          ),
                        );
                    fromVisitingScreen = true;
                  },
                  isVisitingScreen: true,
                  place: place,
                  url: place.urls,
                  type: place.placeType,
                  name: place.name,
                  aspectRatio: AppCardSize.visitingCardDismiss,
                  details: [
                    Text(
                      place.name,
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
                      '${AppStrings.closed} 09:00',
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
      ),
    );
  }
}

class _VisitedWidget extends StatelessWidget {
  const _VisitedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final db = context.read<AppDb>();
    final orientation = MediaQuery.of(context).orientation == Orientation.portrait;

    return FutureBuilder(
      future: context.read<VisitedScreenBloc>().getVisitedPlaces(db),
      // ignore: avoid_types_on_closure_parameters
      builder: (_, AsyncSnapshot<List<DbPlace>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final visitedPlaces = snapshot.data;

          return ReorderableListView.builder(
            onReorder: (oldIndex, newIndex) async {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              final place = visitedPlaces!.removeAt(oldIndex);
              visitedPlaces.insert(newIndex, place);
              for (var i = 0; i < visitedPlaces.length; i++) {
                final updatedPlace = visitedPlaces[i].copyWith(index: Value<int>(i));
                await db.updatePlace(updatedPlace);
              }
            },
            itemCount: visitedPlaces!.length,
            itemBuilder: (_, index) {
              final place = visitedPlaces[index];

              return _VisitedPlacesList(
                key: ObjectKey(index),
                orientation: orientation,
                place: place,
                db: db,
                theme: theme,
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class _VisitedPlacesList extends StatelessWidget {
  final bool orientation;
  final DbPlace place;
  final AppDb db;
  final ThemeData theme;

  const _VisitedPlacesList({
    Key? key,
    required this.orientation,
    required this.place,
    required this.db,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: orientation ? AppCardSize.visitingCardDismiss : AppCardSize.visitingCardDismissLandscape,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 11.0),
        child: PlaceCard(
          placeIndex: place.id,
          actionThree: () async {
            debugPrint('pressed_share_place');
          },
          isVisitingScreen: true,
          place: place,
          url: place.urls,
          type: place.placeType,
          name: place.name,
          aspectRatio: AppCardSize.visitingCardDismiss,
          details: [
            Text(
              place.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 2),
            const Text(
              '${AppStrings.targetReach} 12 окт. 2022',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.detailsText,
            ),
            const SizedBox(height: 10),
            const Text(
              '${AppStrings.closed} 09:00',
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
          actionTwo: const PlaceIcons(
            assetName: AppAssets.share,
            width: 22,
            height: 22,
          ),
        ),
      ),
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
          AppStrings.emptyList,
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
