import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/blocs/search_history/search_history_bloc.dart';
import 'package:places/blocs/search_screen/search_screen_bloc.dart';
import 'package:places/data/api/api_places.dart';

import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/providers/search_data_provider.dart';
import 'package:places/redux/action/action.dart';
import 'package:places/redux/action/search_action.dart';
import 'package:places/redux/state/appstate.dart';
import 'package:places/ui/res/app_assets.dart';
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

  const SearchBar({
    Key? key,
    this.readOnly,
    required this.isSearchPage,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final FocusNode focusNode = FocusNode();

  bool autofocus = true;

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);
    final filteredPlaces = SearchScreenBloc().filteredPlaces;
    final interactor = PlaceInteractor(
      repository: PlaceRepository(
        apiPlaces: ApiPlaces(),
      ),
    );
    final searchStoryList = PlaceInteractor.searchHistoryList;

    context.watch<SearchDataProvider>();

    return Padding(
      padding: const EdgeInsets.only(
        // top: 30.0,
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
                  child: TextField(
                    style: theme.textTheme.bodyLarge,
                    textCapitalization: TextCapitalization.sentences,
                    controller: interactor.controller,
                    autofocus: autofocus,
                    focusNode: focusNode,
                    readOnly: widget.readOnly ?? true,
                    onChanged: (value) {
                      interactor.query = value;

                      context.read<SearchScreenBloc>()
                        ..activeFocus(isActive: true)
                        ..searchPlaces(value, interactor.controller);
                      context.read<SearchScreenBloc>().add(PlacesFoundEvent());
                      if (interactor.controller.text.isEmpty) {
                        filteredPlaces.clear();
                      }
                    },
                    onTap: () {
                      // context.read<SearchHistoryBloc>().activeFocus(isActive: true);
                      // Если страница поиска
                      if (widget.isSearchPage) {
                        // Если история поиска не пустая, то отправляем в state список из истории поиска
                        if (searchStoryList.isNotEmpty) {
                          context.read<SearchHistoryBloc>().add(AddItemToHistoryEvent());
                          context.read<SearchHistoryBloc>().activeFocus(isActive: true);
                          // store.dispatch(
                          //   SearchHistoryHasValueAction(
                          //     searchStoryList: searchStoryList,
                          //     showHistoryList: showHistoryList,
                          //   ),
                          // );
                        } else {
                          // Иначе просто отправляем в action список найденных мест
                          context.read<SearchScreenBloc>().add(PlacesFoundEvent());
                        }
                      }

                      if (!widget.isSearchPage) {
                        Navigator.of(context).push(
                          MaterialPageRoute<SightSearchScreen>(
                            builder: (context) => const SightSearchScreen(),
                          ),
                        );
                      } else {
                        return;
                      }
                    },
                    onSubmitted: (value) {
                      // interactor.query = value;
                      // // if (filteredPlaces.isNotEmpty) {
                      // //   store.dispatch(
                      // //     PlacesFoundAction(filteredPlaces: filteredPlaces),
                      // //   );
                      // // } else {
                      // //   store.dispatch(
                      // //     PlacesEmptyAction(),
                      // //   );
                      // // }
                      // context.read<SearchScreenBloc>().searchPlaces(value, interactor.controller);
                      // if (interactor.controller.text.isEmpty) {
                      //   filteredPlaces.clear();
                      // }
                      // // if(!interactor.hasFocus) {
                      // //   context.read<SearchScreenBloc>().add(PlacesFoundEvent());
                      // // }
                      context.read<SearchHistoryBloc>()
                        ..saveSearchHistory(value, interactor.controller)
                        ..activeFocus(isActive: false);
                      context.read<SearchScreenBloc>().add(PlacesFoundEvent());
                      // // context.read<SearchHistoryBloc>().add(AddItemToHistoryEvent());
                      // interactor.controller.clear();
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIconConstraints: const BoxConstraints(
                        maxWidth: 24,
                        maxHeight: 24,
                      ),
                      hintText: 'Поиск',
                      hintStyle: AppTypography.textText16Search,
                      suffixIcon: focusNode.hasFocus
                          ? SuffixIcon(controller: interactor.controller, theme: theme)
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
