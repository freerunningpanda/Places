import 'package:flutter/material.dart';

import 'package:places/blocs/search_history/search_history_bloc.dart';
import 'package:places/blocs/search_screen/search_screen_bloc.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/filters_screen/filters_screen.dart';
import 'package:places/ui/screens/res/custom_colors.dart';
import 'package:places/ui/screens/sight_search_screen.dart/sight_search_screen.dart';
import 'package:places/ui/widgets/sight_icons.dart';
import 'package:places/ui/widgets/suffix_icon.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  final bool? readOnly;
  final bool isSearchPage;
  final TextEditingController searchController;

  const SearchBar({
    Key? key,
    this.readOnly,
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
    // final filteredPlaces = SearchScreenBloc().filteredPlaces;
    final interactor = PlaceInteractor(
      repository: PlaceRepository(
        apiPlaces: ApiPlaces(),
      ),
    );
    final searchStoryList = PlaceInteractor.searchHistoryList;
    // debugPrint('SearchScreenBloc().filteredPlaces: ${SearchScreenBloc().filteredPlaces}');

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
                const SightIcons(
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
                    onChanged: (value) {
                      interactor.query = value;

                      context.read<SearchScreenBloc>()
                        ..activeFocus(isActive: true)
                        ..searchPlaces(value, widget.searchController);
                        // Не виджет истории поиска. Поэтому isHistoryClear: false
                        // Параметр isHistoryClear отвечает за отображение всех найденных мест
                        // После очистки истории поиска
                      context.read<SearchScreenBloc>().add(
                            PlacesFoundEvent(
                              isHistoryClear: false,
                              fromFiltersScreen: false,
                              isQueryEmpty: interactor.query.isEmpty,
                            ),
                          );
                    },
                    // По клику на поле поиска
                    onTap: () {
                      // Если виджет searchBar на экране поиска мест
                      if (widget.isSearchPage) {
                        // Если история поиска не пустая, то вызываем event показа истории поиска
                        if (searchStoryList.isNotEmpty) {
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
                        // Просто переходим на экран поиска мест
                        Navigator.of(context).push(
                          MaterialPageRoute<SightSearchScreen>(
                            builder: (context) => const SightSearchScreen(),
                          ),
                        );
                      }
                    },
                    // При отправке данных из поиска
                    onFieldSubmitted: (value) {
                      context.read<SearchHistoryBloc>()

                        // Добавляем значение из поиска в список истории поиска
                        ..saveSearchHistory(value, widget.searchController)
                        // Вызываем event добавления места в историю поиска
                        ..add(
                          AddItemToHistoryEvent(
                            isDeleted: false,
                            index: widget.searchController.text,
                            hasFocus: false,
                          ),
                        );

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
                      suffixIcon: focusNode.hasFocus
                          ? SuffixIcon(controller: widget.searchController, theme: theme)
                          : IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<FilterScreen>(
                                    builder: (context) => const FilterScreen(),
                                  ),
                                );
                                debugPrint('🟡---------filters button pressed');
                              },
                              icon: const SightIcons(assetName: AppAssets.filter, width: 24, height: 24),
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
