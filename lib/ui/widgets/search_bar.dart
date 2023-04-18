import 'package:flutter/material.dart';

import 'package:places/blocs/search_history/search_history_bloc.dart';
import 'package:places/blocs/search_screen/search_screen_bloc.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/filters_screen/filters_screen.dart';
import 'package:places/ui/screens/place_search_screen.dart/place_search_screen.dart';
import 'package:places/ui/screens/res/custom_colors.dart';
import 'package:places/ui/widgets/place_icons.dart';
import 'package:places/ui/widgets/suffix_icon.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  final bool? readOnly;
  final bool isMainPage;
  final bool isSearchPage;
  final TextEditingController searchController;

  const SearchBar({
    Key? key,
    this.readOnly,
    required this.isMainPage,
    required this.isSearchPage,
    required this.searchController,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final FocusNode focusNode = FocusNode();

  PlaceInteractor interactor = PlaceInteractor(
    repository: PlaceRepository(
      apiPlaces: ApiPlaces(),
    ),
  );
  bool autofocus = true;

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);
    final interactor = PlaceInteractor(
      repository: PlaceRepository(
        apiPlaces: ApiPlaces(),
      ),
    );
    final searchStoryList = PlaceInteractor.searchHistoryList;
    final bloc = context.read<SearchHistoryBloc>();
    final db = context.read<AppDb>();

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 34,
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: customColors.color,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const PlaceIcons(
                  assetName: AppAssets.search,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: TextFormField(
                    style: theme.textTheme.bodyLarge,
                    textCapitalization: TextCapitalization.sentences,
                    controller: widget.searchController,
                    autofocus: autofocus,
                    focusNode: focusNode,
                    readOnly: widget.readOnly ?? true,
                    onChanged: (value) async {
                      interactor.query = value;

                      context.read<SearchScreenBloc>().activeFocus(isActive: true);
                      final foundedPlaces = await context.read<SearchScreenBloc>().searchPlaces(value, db);

                      // Не виджет истории поиска. Поэтому isHistoryClear: false
                      // Параметр isHistoryClear отвечает за отображение всех найденных мест
                      // После очистки истории поиска
                      // ignore: use_build_context_synchronously
                      context.read<SearchScreenBloc>().add(
                            PlacesFoundEvent(
                              filteredPlaces: foundedPlaces,
                              isHistoryClear: false,
                              fromFiltersScreen: false,
                              searchHistoryIsEmpty: searchStoryList.isEmpty, // Чтобы обновить стейт экрана
                              // Если крайнее место было удалено из истории
                              isQueryEmpty: interactor.query.isEmpty, // Для отображения найденных по фильтру мест
                              // При пустом поисковом запросе
                              db: db,
                            ),
                          );
                    },
                    // По клику на поле поиска
                    onTap: () async {
                      // Если виджет searchBar на экране поиска мест
                      if (widget.isSearchPage) {
                        // Загружаем историю из БД
                        await bloc.loadHistorys(db);
                        // Если история поиска не пустая, то вызываем event показа истории поиска
                        if (searchStoryList.isNotEmpty || bloc.list.isNotEmpty) {
                          // ignore: use_build_context_synchronously
                          context.read<SearchHistoryBloc>().add(
                                ShowHistoryEvent(
                                  isDeleted: false,
                                  hasFocus: true,
                                ),
                              );
                        }
                      }

                      // Если виджет searchBar на главном экране
                      if (!widget.isSearchPage) {
                        // Получить места из БД помеченные только как для поиска
                        // final foundedPlaces = await db.searchedPlacesEntries;
                        // Получить места с экрана фильтров из БД
                        final filteredList = await db.allPlacesEntries;

                        // ignore: use_build_context_synchronously
                        context.read<SearchScreenBloc>().add(
                              PlacesFoundEvent(
                                // filteredPlaces: foundedPlaces.isEmpty ? filteredList : foundedPlaces,
                                filteredPlaces: filteredList,
                                isHistoryClear: false,
                                fromFiltersScreen: false,
                                searchHistoryIsEmpty: searchStoryList.isEmpty, // Чтобы обновить стейт экрана
                                // Если крайнее место было удалено из истории
                                isQueryEmpty: interactor.query.isEmpty, // Для отображения найденных по фильтру мест
                                // При пустом поисковом запросе
                                db: db,
                              ),
                            );
                        // Просто переходим на экран поиска мест
                        // ignore: use_build_context_synchronously
                        await Navigator.of(context).push(
                          MaterialPageRoute<PlaceSearchScreen>(
                            builder: (_) => const PlaceSearchScreen(),
                          ),
                        );
                        // ignore: use_build_context_synchronously
                      }
                    },
                    // При отправке данных из поиска
                    onFieldSubmitted: (value) async {
                      // Добавляем значение из поиска в БД
                      bloc
                        // ignore: unawaited_futures
                        ..addHistory(widget.searchController.text, db)
                        // ignore: unawaited_futures
                        ..loadHistorys(db);

                      context
                          .read<SearchHistoryBloc>()

                          // Добавляем значение из поиска в список истории поиска
                          // Вызываем event добавления места в историю поиска
                          .add(
                            AddItemToHistoryEvent(
                              isDeleted: false,
                              text: widget.searchController.text,
                              hasFocus: false,
                            ),
                          );

                      // await db.addPlacesToSearchScreen(PlaceInteractor.foundedPlaces, isSearchScreen: true);

                      // Очистить строку поиска после нажатия кнопки submit
                      widget.searchController.clear();
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIconConstraints: const BoxConstraints(
                        maxWidth: 24,
                        maxHeight: 24,
                      ),
                      hintText: AppString.search,
                      hintStyle: AppTypography.textText16Search,
                      suffixIcon: focusNode.hasFocus && !widget.isMainPage
                          ? SuffixIcon(controller: widget.searchController, theme: theme)
                          : IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<FilterScreen>(
                                    builder: (_) => const FilterScreen(),
                                  ),
                                );
                                debugPrint('🟡---------filters button pressed');
                              },
                              icon: const PlaceIcons(assetName: AppAssets.filter, width: 24, height: 24),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
