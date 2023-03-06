import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/favorite/favorite_bloc.dart';
import 'package:places/blocs/filters_screen_bloc/filters_screen_bloc.dart';
import 'package:places/blocs/search_screen/search_screen_bloc.dart';
import 'package:places/cubits/distance_slider_cubit/distance_slider_cubit.dart';
import 'package:places/cubits/places_list/places_list_cubit.dart';
import 'package:places/cubits/show_places_button/show_places_button_cubit.dart';

import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/model/place.dart';
import 'package:places/mocks.dart';
import 'package:places/providers/filter_data_provider.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/sight_search_screen.dart/sight_search_screen.dart';
import 'package:places/ui/widgets/action_button.dart';
import 'package:places/ui/widgets/sight_icons.dart';

class FilterScreen extends StatelessWidget {
  final VoidCallback? onPressed;
  const FilterScreen({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clearFilters = context.read<FilterDataProvider>().clearAllFilters;
    final size = MediaQuery.of(context).size;
    // ignore: unnecessary_statements
    context.watch<FilterDataProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _AppBar(
        onPressed: clearFilters,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 24,
          right: 16,
          bottom: 8.0,
        ),
        child: BlocBuilder<PlacesListCubit, PlacesListState>(
          builder: (context, state) {
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
                    filters: FilterDataProvider.filters,
                    activeFilters: PlaceInteractor.activeFilters,
                  ),
                  if (size.width <= 320) SizedBox(height: size.height / 10) else SizedBox(height: size.height / 3.5),
                  Expanded(
                    child: _DistanceSlider(
                      places: state.places,
                    ),
                  ),
                  if (size.width <= 320)
                    Expanded(
                      child: ActionButton(
                        activeFilters: PlaceInteractor.activeFilters,
                        title: AppString.showPlaces,
                        rangeValues: Mocks.rangeValues,
                        onTap: () => goToSearchScreen(context),
                      ),
                    )
                  else
                    ActionButton(
                      activeFilters: PlaceInteractor.activeFilters,
                      title: AppString.showPlaces,
                      rangeValues: Mocks.rangeValues,
                      onTap: () => goToSearchScreen(context),
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

  void goToSearchScreen(BuildContext context) {
    context.read<SearchScreenBloc>().add(PlacesFoundEvent());
    Navigator.of(context).push<SightSearchScreen>(
      MaterialPageRoute(
        builder: (context) => const SightSearchScreen(),
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
      AppString.categories,
      style: AppTypography.categoriesGrey,
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onPressed;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const _AppBar({Key? key, required this.onPressed}) : super(key: key);
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
          _ClearButtonWidget(
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}

class _ClearButtonWidget extends StatefulWidget {
  final VoidCallback? onPressed;
  const _ClearButtonWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<_ClearButtonWidget> createState() => _ClearButtonWidgetState();
}

class _ClearButtonWidgetState extends State<_ClearButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      child: const Text(
        AppString.clear,
        style: AppTypography.clearButton,
      ),
    );
  }
}

class _FiltersTable extends StatefulWidget {
  final List<Category> filters;
  final List<Category> activeFilters;
  final List<Place> places;
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

    // ignore: unnecessary_statements
    context.watch<FilterDataProvider>();

    return Container(
      height: size.width <= 320 ? 90 : 170,
      alignment: const Alignment(0.0, -0.8),
      child: Builder(
        builder: (context) {
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
  final List<Place> placeList;

  const _ItemFiltersListBigScreens({
    Key? key,
    required this.filtersTable,
    required this.placeList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 24,
      runSpacing: 40,
      children: filtersTable.filters
          .asMap()
          .map(
            (i, category) => MapEntry(
              i,
              _ItemFilter(
                category: category,
                isEnabled: category.isEnabled,
                name: category.title,
                assetName: category.assetName ?? 'null',
                onTap: () {
                  final filteredByType =
                      filtersTable.places.where((place) => place.placeType.contains(category.placeType)).toList();
                  context.read<FiltersScreenBloc>().addToFilteredList(
                        category: category,
                        filteredByType: filteredByType,
                      );
                  context.read<ShowPlacesButtonCubit>().showCount(places: placeList);

                  if (!category.isEnabled) {
                    context.read<FiltersScreenBloc>().add(
                          FiltersScreenEvent(
                            category: category,
                            isEnabled: category.isEnabled = true,
                            categoryIndex: i,
                          ),
                        );
                  } else {
                    context.read<FiltersScreenBloc>().add(
                          FiltersScreenEvent(
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
  final List<Place> placeList;

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
                isEnabled: category.isEnabled,
                name: category.title,
                assetName: category.assetName ?? 'null',
                onTap: () {
                  final filteredByType =
                      filtersTable.places.where((place) => place.placeType.contains(category.placeType)).toList();
                  context.read<FiltersScreenBloc>().addToFilteredList(
                        category: category,
                        filteredByType: filteredByType,
                      );
                  context.read<ShowPlacesButtonCubit>().showCount(places: placeList);

                  if (!category.isEnabled) {
                    context.read<FiltersScreenBloc>().add(
                          FiltersScreenEvent(
                            category: category,
                            isEnabled: category.isEnabled = true,
                            categoryIndex: i,
                          ),
                        );
                  } else {
                    context.read<FiltersScreenBloc>().add(
                          FiltersScreenEvent(
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
          // height: height,
          child: Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: onTap,
                child: SizedBox(
                  height: 64,
                  width: 64,
                  child: BlocBuilder<FiltersScreenBloc, FiltersScreenState>(
                    builder: (context, state) {
                      if (state is IsEnabledState) {
                        return category.isEnabled
                            ? Opacity(
                                opacity: 0.5,
                                child: CircleAvatar(
                                  backgroundColor: theme.canvasColor,
                                  child: SightIcons(
                                    assetName: assetName,
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: theme.canvasColor,
                                child: SightIcons(
                                  assetName: assetName,
                                  width: 32,
                                  height: 32,
                                ),
                              );
                      } else if (state is IsNotEnabledState) {
                        return category.isEnabled
                            ? Opacity(
                                opacity: 0.5,
                                child: CircleAvatar(
                                  backgroundColor: theme.canvasColor,
                                  child: SightIcons(
                                    assetName: assetName,
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: theme.canvasColor,
                                child: SightIcons(
                                  assetName: assetName,
                                  width: 32,
                                  height: 32,
                                ),
                              );
                      }
                      throw ArgumentError('Bad state');
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
          builder: (context, state) {
            if (state is IsEnabledState) {
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
                        child: const SightIcons(
                          assetName: AppAssets.check,
                          width: 16,
                          height: 16,
                        ),
                      ),
                    )
                  : const SizedBox();
            } else if (state is IsNotEnabledState) {
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
                        child: const SightIcons(
                          assetName: AppAssets.check,
                          width: 16,
                          height: 16,
                        ),
                      ),
                    )
                  : const SizedBox();
            } else {
              throw ArgumentError('Bad state');
            }
          },
        ),
      ],
    );
  }
}

class _DistanceSlider extends StatefulWidget {
  final List<Place> places;
  const _DistanceSlider({
    Key? key,
    required this.places,
  }) : super(key: key);

  @override
  State<_DistanceSlider> createState() => _DistanceSliderState();
}

class _DistanceSliderState extends State<_DistanceSlider> {
  double min = 100;
  double max = 10000;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<DistanceSliderCubit, DistanceSliderState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppString.distantion,
                  style: theme.textTheme.displayMedium,
                ),
                Text(
                  'от ${state.rangeValues.start.toInt()} до ${state.rangeValues.end.toInt()} м',
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 24),
            RangeSlider(
              values: state.rangeValues,
              min: min,
              max: max,
              onChanged: (values) {
                context.read<DistanceSliderCubit>().changeArea(start: values.start, end: values.end);
                context.read<ShowPlacesButtonCubit>().showCount(places: widget.places);
              },
            ),
          ],
        );
      },
    );
  }
}
