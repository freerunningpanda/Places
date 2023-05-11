import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:places/blocs/filters_screen_bloc/filters_screen_bloc.dart';
import 'package:places/blocs/search_screen/search_screen_bloc.dart';
import 'package:places/cubits/distance_slider_cubit/distance_slider_cubit.dart';
import 'package:places/cubits/places_list/places_list_cubit.dart';
import 'package:places/cubits/show_places_button/show_places_button_cubit.dart';
import 'package:places/data/database/database.dart';

import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/store/app_preferences.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/place_search_screen.dart/place_search_screen.dart';
import 'package:places/ui/widgets/action_button.dart';
import 'package:places/ui/widgets/place_icons.dart';

class FilterScreen extends StatelessWidget {
  final VoidCallback? onPressed;
  const FilterScreen({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final db = context.read<AppDb>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const _AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 24,
          right: 16,
          bottom: 8.0,
        ),
        child: BlocBuilder<PlacesListCubit, PlacesListState>(
          builder: (_, state) {
            if (state is PlacesListEmptyState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PlacesListLoadedState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Title(),
                  const SizedBox(height: 24),
                  _FiltersTable(
                    places: state.places,
                    filters: FiltersScreenBloc.filters,
                    activeFilters: PlaceInteractor.activeFilters,
                  ),
                  if (size.width <= 320) SizedBox(height: size.height / 10) else SizedBox(height: size.height / 3.5),
                  FutureBuilder(
                    future: Permission.location.isDenied,
                    builder: (_, snapshot) {
                      return snapshot.hasData && snapshot.data == true
                          ? AbsorbPointer(
                              child: _DistanceSlider(
                                filters: FiltersScreenBloc.filters,
                                places: state.places,
                              ),
                            )
                          : _DistanceSlider(filters: FiltersScreenBloc.filters, places: state.places);
                    },
                  ),
                  const Spacer(),
                  if (size.width <= 320)
                    Expanded(
                      child: ActionButton(
                        activeFilters: PlaceInteractor.activeFilters,
                        title: AppStrings.showPlaces,
                        rangeValues: Mocks.rangeValues,
                        onTap: () => goToSearchScreen(context, db),
                      ),
                    )
                  else
                    ActionButton(
                      activeFilters: PlaceInteractor.activeFilters,
                      title: AppStrings.showPlaces,
                      rangeValues: Mocks.rangeValues,
                      onTap: () => goToSearchScreen(context, db),
                    ),
                ],
              );
            } else {
              throw ArgumentError('Bad State');
            }
          },
        ),
      ),
    );
  }

  Future<void> goToSearchScreen(BuildContext context, AppDb db) async {
    // Не виджет истории поиска. Поэтому isHistoryClear: false
    // Параметр isHistoryClear отвечает за отображение всех найденных мест
    // После очистки истории поиска
    await db.deleteAllPlaces();
    // Добавить места для последующего поиска на экране поиска

    // await db.addPlacesToSearchScreen(
    //   PlaceInteractor.filtersWithDistance.toList(),
    //   isSearchScreen: true,
    // );

    // Добавить места, которые будут отображаться на экране поиска если очистить историю поиска
    await db.addPlacesToSearchScreen(
      PlaceInteractor.filtersWithDistance.toList(),
      isSearchScreen: false,
    );

    final list = await db.allPlacesEntries;
    if (await Permission.location.isDenied) {
      // ignore: use_build_context_synchronously
      context.read<SearchScreenBloc>().add(
            PlacesFoundEvent(
              searchHistoryIsEmpty: PlaceInteractor.searchHistoryList.isEmpty,
              filteredPlaces: list,
              isHistoryClear: false,
              fromFiltersScreen: true,
              isQueryEmpty: true,
              db: db,
            ),
          );
    } else if (await Permission.location.isGranted) {
      // ignore: use_build_context_synchronously
      context.read<SearchScreenBloc>().add(
            PlacesNoGeoEvent(
              searchHistoryIsEmpty: PlaceInteractor.searchHistoryList.isEmpty,
              filteredPlaces: list,
              isHistoryClear: false,
              fromFiltersScreen: true,
              isQueryEmpty: true,
              db: db,
            ),
          );
    }

    // ignore: use_build_context_synchronously
    await Navigator.of(context).push<PlaceSearchScreen>(
      MaterialPageRoute(
        builder: (_) => const PlaceSearchScreen(),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      AppStrings.categories,
      style: AppTypography.categoriesGrey,
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const _AppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: AppBar(
        leading: IconButton(
          onPressed: () {
            debugPrint('🟡---------chevrone back pressed');
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left),
          color: Theme.of(context).iconTheme.color,
        ),
        toolbarHeight: 86,
        bottomOpacity: 0.0,
        actions: [
          FutureBuilder(
            future: Permission.location.isDenied,
            builder: (_, snapshot) {
              return snapshot.hasData && snapshot.data == true
                  ? _ClearButtonWidget(
                      onTap: () {
                        context.read<ShowPlacesButtonCubit>().clearAllFiltersNoGeo();
                        context.read<FiltersScreenBloc>().add(ClearAllFiltersEvent());
                      },
                    )
                  : _ClearButtonWidget(
                      onTap: () {
                        context.read<ShowPlacesButtonCubit>().clearAllFilters();
                        context.read<FiltersScreenBloc>().add(ClearAllFiltersEvent());
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}

class _ClearButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  const _ClearButtonWidget({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: const Text(
        AppStrings.clear,
        style: AppTypography.clearButton,
      ),
    );
  }
}

class _FiltersTable extends StatefulWidget {
  final List<Category> filters;
  final List<Category> activeFilters;
  final List<DbPlace> places;
  const _FiltersTable({
    Key? key,
    required this.filters,
    required this.activeFilters,
    required this.places,
  }) : super(key: key);

  @override
  State<_FiltersTable> createState() => _FiltersTableState();
}

class _FiltersTableState extends State<_FiltersTable> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.width <= 320 ? 90 : 170,
      alignment: const Alignment(0.0, -0.8),
      child: Builder(
        builder: (_) {
          return size.width <= 320
              ? _ItemFiltersListSmallScreens(
                  filtersTable: widget,
                  placeList: widget.places,
                )
              : _ItemFiltersListBigScreens(
                  filtersTable: widget,
                  placeList: widget.places,
                );
        },
      ),
    );
  }
}

class _ItemFiltersListBigScreens extends StatelessWidget {
  final _FiltersTable filtersTable;
  final List<DbPlace> placeList;

  const _ItemFiltersListBigScreens({
    Key? key,
    required this.filtersTable,
    required this.placeList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 14,
      runSpacing: 40,
      children: filtersTable.filters
          .asMap()
          .map(
            (i, category) => MapEntry(
              i,
              _ItemFilter(
                category: category,
                isEnabled: AppPreferences.getCategoryByName(category.title),
                name: category.title,
                assetName: category.assetName ?? 'null',
                onTap: () async {
                  final filteredByType =
                      filtersTable.places.where((place) => place.placeType.contains(category.placeType)).toList();
                  await context.read<FiltersScreenBloc>().addToFilteredList(
                        category: category,
                        filteredByType: filteredByType,
                      );
                  if (await Permission.location.isDenied) {
                    // ignore: use_build_context_synchronously
                    await context.read<ShowPlacesButtonCubit>().showCountNoGeo(places: placeList);
                  } else if (await Permission.location.isGranted) {
                    // ignore: use_build_context_synchronously
                    await context.read<ShowPlacesButtonCubit>().showCount(places: placeList);
                  }

                  if (!category.isEnabled) {
                    await AppPreferences.setCategoryByName(
                      title: category.title,
                      isEnabled: category.isEnabled = true,
                    );
                    await AppPreferences.setCategoryByStatus(
                      type: category.placeType,
                      isEnabled: category.isEnabled = true,
                    );
                    // ignore: use_build_context_synchronously
                    context.read<FiltersScreenBloc>().add(
                          AddRemoveFilterEvent(
                            category: category,
                            isEnabled: category.isEnabled = true,
                            categoryIndex: i,
                          ),
                        );
                    // ignore: use_build_context_synchronously
                    context.read<ShowPlacesButtonCubit>().resetToZero();
                  } else {
                    await AppPreferences.setCategoryByName(
                      title: category.title,
                      isEnabled: category.isEnabled = false,
                    );
                    await AppPreferences.setCategoryByStatus(
                      type: category.placeType,
                      isEnabled: category.isEnabled = false,
                    );
                    // ignore: use_build_context_synchronously
                    context.read<FiltersScreenBloc>().add(
                          AddRemoveFilterEvent(
                            category: category,
                            isEnabled: category.isEnabled = false,
                            categoryIndex: i,
                          ),
                        );
                    debugPrint('🟡--------- isEnabled ${category.isEnabled}');
                    debugPrint('🟡--------- Удалена из активных категорий: $category');
                  }
                },
              ),
            ),
          )
          .values
          .toList(),
    );
  }
}

class _ItemFiltersListSmallScreens extends StatelessWidget {
  final _FiltersTable filtersTable;
  final List<DbPlace> placeList;

  const _ItemFiltersListSmallScreens({
    Key? key,
    required this.filtersTable,
    required this.placeList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: filtersTable.filters
          .asMap()
          .map(
            (i, category) => MapEntry(
              i,
              _ItemFilter(
                category: category,
                isEnabled: AppPreferences.getCategoryByName(category.title),
                name: category.title,
                assetName: category.assetName ?? 'null',
                onTap: () async {
                  final filteredByType =
                      filtersTable.places.where((place) => place.placeType.contains(category.placeType)).toList();
                  await context.read<FiltersScreenBloc>().addToFilteredList(
                        category: category,
                        filteredByType: filteredByType,
                      );
                  if (await Permission.location.isDenied) {
                    // ignore: use_build_context_synchronously
                    await context.read<ShowPlacesButtonCubit>().showCountNoGeo(places: placeList);
                  } else if (await Permission.location.isGranted) {
                    // ignore: use_build_context_synchronously
                    await context.read<ShowPlacesButtonCubit>().showCount(places: placeList);
                  }

                  if (!category.isEnabled) {
                    await AppPreferences.setCategoryByName(
                      title: category.title,
                      isEnabled: category.isEnabled = true,
                    );
                    await AppPreferences.setCategoryByStatus(
                      type: category.placeType,
                      isEnabled: category.isEnabled = true,
                    );
                    // ignore: use_build_context_synchronously
                    context.read<FiltersScreenBloc>().add(
                          AddRemoveFilterEvent(
                            category: category,
                            isEnabled: category.isEnabled = true,
                            categoryIndex: i,
                          ),
                        );
                    // ignore: use_build_context_synchronously
                    context.read<ShowPlacesButtonCubit>().resetToZero();
                  } else {
                    await AppPreferences.setCategoryByName(
                      title: category.title,
                      isEnabled: category.isEnabled = false,
                    );
                    await AppPreferences.setCategoryByStatus(
                      type: category.placeType,
                      isEnabled: category.isEnabled = false,
                    );
                    // ignore: use_build_context_synchronously
                    context.read<FiltersScreenBloc>().add(
                          AddRemoveFilterEvent(
                            category: category,
                            isEnabled: category.isEnabled = false,
                            categoryIndex: i,
                          ),
                        );
                    debugPrint('🟡--------- isEnabled ${category.isEnabled}');
                    debugPrint('🟡--------- Удалена из активных категорий: $category');
                  }
                },
              ),
            ),
          )
          .values
          .toList(),
    );
  }
}

class _ItemFilter extends StatelessWidget {
  final String name;
  final bool isEnabled;
  final Category category;
  final VoidCallback onTap;
  final String assetName;

  const _ItemFilter({
    Key? key,
    required this.name,
    required this.isEnabled,
    required this.category,
    required this.onTap,
    required this.assetName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        SizedBox(
          width: 98,
          child: Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: onTap,
                child: SizedBox(
                  height: 64,
                  width: 64,
                  child: BlocBuilder<FiltersScreenBloc, FiltersScreenState>(
                    builder: (_, state) {
                      return category.isEnabled
                          ? Opacity(
                              opacity: 0.5,
                              child: CircleAvatar(
                                backgroundColor: theme.canvasColor,
                                child: PlaceIcons(
                                  assetName: assetName,
                                  width: 32,
                                  height: 32,
                                ),
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: theme.canvasColor,
                              child: PlaceIcons(
                                assetName: assetName,
                                width: 32,
                                height: 32,
                              ),
                            );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                name,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall,
              ),
            ],
          ),
        ),
        BlocBuilder<FiltersScreenBloc, FiltersScreenState>(
          builder: (_, state) {
            return category.isEnabled
                ? Positioned(
                    right: 16,
                    bottom: 25,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 2,
                      ),
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: theme.focusColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const PlaceIcons(
                        assetName: AppAssets.check,
                        width: 16,
                        height: 16,
                      ),
                    ),
                  )
                : const SizedBox();
          },
        ),
      ],
    );
  }
}

class _DistanceSlider extends StatelessWidget {
  final List<Category> filters;
  final List<DbPlace> places;
  const _DistanceSlider({
    Key? key,
    required this.filters,
    required this.places,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final min = context.read<DistanceSliderCubit>().min;
    final max = context.read<DistanceSliderCubit>().max;

    return BlocBuilder<DistanceSliderCubit, DistanceSliderState>(
      builder: (_, state) {
        return FutureBuilder(
          future: Permission.location.isDenied,
          builder: (_, snapshot) {
            return snapshot.hasData && snapshot.data == true
                ? Opacity(
                    opacity: 0.3,
                    child: Column(children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(AppStrings.distantion, style: theme.textTheme.displayMedium),
                        Text(
                          'от ${state.rangeValues.start.toInt()} до ${state.rangeValues.end.toInt()} м',
                          style: theme.textTheme.titleMedium,
                        ),
                      ]),
                      const SizedBox(height: 24),
                      RangeSlider(
                        values: state.rangeValues,
                        min: min,
                        max: max,
                        onChanged: (values) {
                          context.read<DistanceSliderCubit>().changeArea(start: values.start, end: values.end);
                          context.read<ShowPlacesButtonCubit>().showCount(places: places);
                          for (final category in filters) {
                            if (category.isEnabled) {
                              context.read<ShowPlacesButtonCubit>().resetToZero();
                            }
                          }
                        },
                      ),
                    ]),
                  )
                : Opacity(
                    opacity: 1,
                    child: Column(children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(AppStrings.distantion, style: theme.textTheme.displayMedium),
                        Text(
                          'от ${state.rangeValues.start.toInt()} до ${state.rangeValues.end.toInt()} м',
                          style: theme.textTheme.titleMedium,
                        ),
                      ]),
                      const SizedBox(height: 24),
                      RangeSlider(
                        values: state.rangeValues,
                        min: min,
                        max: max,
                        onChanged: (values) {
                          context.read<DistanceSliderCubit>().changeArea(start: values.start, end: values.end);
                          context.read<ShowPlacesButtonCubit>().showCount(places: places);
                          for (final category in filters) {
                            if (category.isEnabled) {
                              context.read<ShowPlacesButtonCubit>().resetToZero();
                            }
                          }
                        },
                      ),
                    ]),
                  );
          },
        );
      },
    );
  }
}
