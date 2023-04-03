import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/details_screen/details_screen_bloc.dart';
import 'package:places/blocs/search_bar/search_bar_bloc.dart';
import 'package:places/blocs/search_history/search_history_bloc.dart';
import 'package:places/blocs/search_screen/search_screen_bloc.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/store/app_preferences.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/place_details/place_details.dart';
import 'package:places/ui/widgets/place_icons.dart';
import 'package:places/ui/widgets/search_appbar.dart';
import 'package:places/ui/widgets/search_bar.dart';

class PlaceSearchScreen extends StatefulWidget {
  const PlaceSearchScreen({Key? key}) : super(key: key);

  @override
  State<PlaceSearchScreen> createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _loadDb();
    final theme = Theme.of(context);
    const readOnly = false;
    const isSearchPage = true;

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const SearchAppBar(),
              const SizedBox(height: 16),
              BlocBuilder<SearchBarBloc, SearchBarState>(
                builder: (_, state) {
                  if (state is SearchBarHasValueState) {
                    return SearchBar(
                      isMainPage: false,
                      isSearchPage: isSearchPage,
                      readOnly: readOnly,
                      searchController: searchController,
                    );
                  } else if (state is SearchBarEmptyState) {
                    return SearchBar(
                      isMainPage: false,
                      isSearchPage: isSearchPage,
                      readOnly: readOnly,
                      searchController: TextEditingController(),
                    );
                  }

                  throw ArgumentError('Bad state');
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BlocBuilder<SearchHistoryBloc, SearchHistoryState>(
                        builder: (_, state) {
                          // Если история поиска пуста, показываем просто список найденных мест
                          if (state is SearchHistoryEmptyState) {
                            return Column(
                              children: [
                                const SizedBox(),
                                _PlaceListWidget(theme: theme),
                              ],
                            );
                          }
                          // Если история не пустая то берём её из state и отображаем на экране
                          else if (state is SearchHistoryHasValueState) {
                            return state.hasFocus
                                // При наличии фокуса в поле ввода, показываем историю поиска (если она есть)
                                ? _SearchHistoryList(
                                    theme: theme,
                                    searchStoryList: state.searchStoryList,
                                    width: width,
                                    controller: searchController,
                                  )
                                // Иначе показываем список найденных мест
                                : Column(
                                    children: [
                                      const SizedBox(),
                                      _PlaceListWidget(theme: theme),
                                    ],
                                  );
                          } else {
                            // В противном случае показываем список найденных мест
                            return Column(
                              children: [
                                const SizedBox(),
                                _PlaceListWidget(theme: theme),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loadDb() async {
    await context.watch<SearchHistoryBloc>().loadHistorys();
  }
}

// Виджет списка найденных мест
class _PlaceListWidget extends StatelessWidget {
  final ThemeData theme;
  const _PlaceListWidget({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<SearchScreenBloc, SearchScreenState>(
      builder: (_, state) {
        // Начальное состояние экрана пустого списка найденных мест
        if (state is SearchScreenEmptyState) {
          return _EmptyListWidget(
            height: height,
            width: width,
            theme: theme,
          );
          // Если места найдены, берём их из state и отображаем на экране
        } else if (state is SearchScreenPlacesFoundState) {
          debugPrint('state.filteredPlaces.length: ${state.filteredPlaces.length}');

          return ListView.builder(
            physics: Platform.isAndroid ? const ClampingScrollPhysics() : const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.filteredPlaces.length,
            itemBuilder: (_, index) {
              final place = state.filteredPlaces[index];

              return _PlaceCardWidget(
                place: place,
                width: width,
                theme: theme,
              );
            },
          );
        }
        // В противном случае отображаем пустой список мест

        return _EmptyListWidget(
          height: height,
          width: width,
          theme: theme,
        );
      },
    );
  }
}

// Виджет пустого списка мест
class _EmptyListWidget extends StatelessWidget {
  final double height;
  final double width;
  final ThemeData theme;

  const _EmptyListWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _EmptyStateWidget(height: height, width: width);
  }
}

// Виджет истории поиска
class _SearchHistoryList extends StatelessWidget {
  final List<SearchHistory> searchStoryList;
  final ThemeData theme;
  final double width;
  final TextEditingController controller;

  const _SearchHistoryList({
    Key? key,
    required this.searchStoryList,
    required this.theme,
    required this.width,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: Platform.isAndroid ? const ClampingScrollPhysics() : const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        _SearchHistoryTitle(theme: theme),
        const SizedBox(height: 4),
        _SearchItem(
          theme: theme,
          searchStoryList: searchStoryList,
          width: width,
          controller: controller,
        ),
        const SizedBox(height: 15),
        _ClearHistoryButton(searchStoryList: searchStoryList),
      ],
    );
  }
}

class _ClearHistoryButton extends StatelessWidget {
  final List<SearchHistory> searchStoryList;
  const _ClearHistoryButton({
    Key? key,
    required this.searchStoryList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // Вызываем event очистки истории поиска
      onPressed: () {
        context.read<SearchHistoryBloc>().add(RemoveAllItemsFromHistory());
        // Для того, чтобы заново показать весь список найденных мест с экрана фильтров
        context.read<SearchScreenBloc>().add(
              PlacesFoundEvent(
                searchHistoryIsEmpty: searchStoryList.isEmpty,
                filteredPlaces: AppPreferences.getPlacesListByDistance()?.toList(),
                isHistoryClear: true,
                fromFiltersScreen: false,
                isQueryEmpty: true,
              ),
            );
      },
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          AppString.clearHistory,
          style: AppTypography.clearButton,
        ),
      ),
    );
  }
}

class _SearchHistoryTitle extends StatelessWidget {
  final ThemeData theme;

  const _SearchHistoryTitle({
    Key? key,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppString.youSearch,
      style: theme.textTheme.labelLarge,
    );
  }
}

class _SearchItem extends StatelessWidget {
  final ThemeData theme;
  final List<SearchHistory> searchStoryList;
  final double width;
  final TextEditingController controller;

  const _SearchItem({
    Key? key,
    required this.theme,
    required this.searchStoryList,
    required this.width,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final historyBloc = context.read<SearchHistoryBloc>();
    final searchBloc = context.read<SearchScreenBloc>();

    return Column(
      children: searchStoryList
          .map(
            (e) => Column(
              children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        final value = controller.text = e.toString();
                        context.read<SearchBarBloc>().add(SearchBarEvent(value: value));
                      },
                      child: SizedBox(
                        width: width * 0.7,
                        child: Text(
                          e.title,
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        historyBloc
                          ..removeItemFromHistory(e.title)
                          ..add(
                            RemoveItemFromHistory(
                              text: e.title,
                              isDeleted: true,
                              hasFocus: true,
                              list: searchStoryList,
                              length: searchStoryList.length,
                            ),
                          );
                        // Чтобы обновить стейт экрана
                        // Если крайнее место было удалено из истории
                        searchBloc.add(
                          PlacesFoundEvent(
                            searchHistoryIsEmpty: searchStoryList.isEmpty,
                            filteredPlaces: AppPreferences.getPlacesListByDistance()?.toList(),
                            isHistoryClear: true,
                            fromFiltersScreen: false,
                            isQueryEmpty: true,
                          ),
                        );
                      },
                      child: const PlaceIcons(assetName: AppAssets.delete, width: 24, height: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
              ],
            ),
          )
          .toList(),
    );
  }
}

class _EmptyStateWidget extends StatelessWidget {
  final double height;
  final double width;

  const _EmptyStateWidget({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: height * 0.2,
          ),
          const PlaceIcons(
            assetName: AppAssets.search,
            width: 64,
            height: 64,
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            AppString.noPlaces,
            style: AppTypography.emptyListTitle,
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: width * 0.6,
            child: const Text(
              AppString.tryToChange,
              style: AppTypography.detailsTextDarkMode,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: height * 0.2,
          ),
        ],
      ),
    );
  }
}

class _PlaceCardWidget extends StatelessWidget {
  final Place place;
  final double width;
  final ThemeData theme;

  const _PlaceCardWidget({
    Key? key,
    required this.place,
    required this.width,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: SizedBox(
            child: Row(
              children: [
                _PlaceImage(place: place),
                const SizedBox(width: 16),
                _PlaceContent(width: width, place: place, theme: theme),
              ],
            ),
          ),
        ),
        _RippleEffect(place: place),
      ],
    );
  }
}

class _RippleEffect extends StatelessWidget {
  final Place place;

  const _RippleEffect({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            context.read<DetailsScreenBloc>().add(DetailsScreenEvent(place: place));
            Navigator.of(context).push<PlaceDetails>(
              MaterialPageRoute(
                builder: (_) => PlaceDetails(
                  place: place,
                  height: 360,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PlaceContent extends StatelessWidget {
  final double width;
  final Place place;
  final ThemeData theme;

  const _PlaceContent({
    Key? key,
    required this.width,
    required this.place,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _PlaceTitle(width: width, place: place, theme: theme),
        const SizedBox(height: 8),
        _PlaceType(place: place, theme: theme),
        const SizedBox(height: 16),
        Container(
          height: 1,
          width: width * 0.73,
          color: theme.dividerColor,
        ),
      ],
    );
  }
}

class _PlaceType extends StatelessWidget {
  final Place place;
  final ThemeData theme;

  const _PlaceType({
    Key? key,
    required this.place,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      place.placeType,
      style: theme.textTheme.bodyMedium,
    );
  }
}

class _PlaceTitle extends StatelessWidget {
  final double width;
  final Place place;
  final ThemeData theme;

  const _PlaceTitle({
    Key? key,
    required this.width,
    required this.place,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.73,
      child: Text(
        place.name,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyLarge,
      ),
    );
  }
}

class _PlaceImage extends StatelessWidget {
  final Place place;

  const _PlaceImage({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(place.urls[0]),
          ),
        ),
      ),
    );
  }
}
