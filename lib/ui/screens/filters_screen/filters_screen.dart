import 'package:flutter/material.dart';
import 'package:places/data/api/api_places.dart';

import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/model/place.dart';
import 'package:places/mocks.dart';
import 'package:places/providers/filter_data_provider.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/widgets/action_button.dart';
import 'package:places/ui/widgets/sight_icons.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  final VoidCallback? onPressed;
  const FilterScreen({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late final List<Place> placeList;
  bool isLoading = false;

  @override
  void initState() {
    getPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final clearFilters = context.read<FilterDataProvider>().clearAllFilters;
    final size = MediaQuery.of(context).size;
    // ignore: unnecessary_statements
    context.watch<PlaceInteractor>();

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
        child: isLoading
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Title(),
                  const SizedBox(height: 24),
                  _FiltersTable(
                    placeList: placeList,
                    filters: FilterDataProvider.filters,
                    activeFilters: FilterDataProvider.activeFilters,
                  ),
                  if (size.width <= 320) SizedBox(height: size.height / 10) else SizedBox(height: size.height / 3.5),
                  Expanded(
                    child: _DistanceSlider(
                      placeList: placeList,
                    ),
                  ),
                  if (size.width <= 320)
                    Expanded(
                      child: ActionButton(
                        counterValue: FilterDataProvider.filtersWithDistance.length,
                        activeFilters: FilterDataProvider.activeFilters,
                        title: '${AppString.showPlaces} (${FilterDataProvider.filtersWithDistance.length})',
                        rangeValues: Mocks.rangeValues,
                        onTap: () {
                          context.read<FilterDataProvider>().showCount(placeList: placeList);
                          context.read<FilterDataProvider>().clearSight(placeList: placeList);
                          debugPrint('🟡---------Длина: ${FilterDataProvider.filtersWithDistance.length}');
                        },
                      ),
                    )
                  else
                    ActionButton(
                      counterValue: FilterDataProvider.filtersWithDistance.length,
                      activeFilters: FilterDataProvider.activeFilters,
                      title: '${AppString.showPlaces} (${FilterDataProvider.filtersWithDistance.length})',
                      rangeValues: Mocks.rangeValues,
                      onTap: () {
                        context.read<FilterDataProvider>().showCount(placeList: placeList);
                        context.read<FilterDataProvider>().clearSight(placeList: placeList);
                        debugPrint('🟡---------Длина: ${FilterDataProvider.filtersWithDistance.length}');
                      },
                    ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<void> getPlaces() async {
    placeList = await PlaceInteractor(apiPlaceRepository: ApiPlaceRepository()).getPlaces();
    setState(() {
      isLoading = true;
    });
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
  final List<String> activeFilters;
  final List<Place> placeList;
  const _FiltersTable({
    Key? key,
    required this.filters,
    required this.activeFilters,
    required this.placeList,
  }) : super(key: key);

  @override
  State<_FiltersTable> createState() => _FiltersTableState();
}

class _FiltersTableState extends State<_FiltersTable> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // ignore: unnecessary_statements
    context.watch<PlaceInteractor>();

    return Container(
      height: size.width <= 320 ? 90 : 170,
      alignment: const Alignment(0.0, -0.8),
      child: Builder(
        builder: (context) {
          return size.width <= 320
              ? _ItemFiltersListSmallScreens(
                  filtersTable: widget,
                  placeList: widget.placeList,
                )
              : _ItemFiltersListBigScreens(
                  filtersTable: widget,
                  placeList: widget.placeList,
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
            (i, e) => MapEntry(
              i,
              _ItemFilter(
                isEnabled: e.isEnabled,
                title: e.title,
                assetName: e.assetName ?? 'null',
                onTap: () {
                  final filteredByType =
                      filtersTable.placeList.where((sight) => sight.placeType.contains(e.title)).toList();
                  if (!e.isEnabled) {
                    FilterDataProvider.filteredMocks.addAll(filteredByType);
                  } else {
                    FilterDataProvider.filteredMocks.clear();
                    FilterDataProvider.filtersWithDistance.clear();
                    debugPrint('🟡---------Добавленные места: ${FilterDataProvider.filteredMocks}');
                  }
                  context.read<FilterDataProvider>().showCount(placeList: placeList);

                  return context.read<FilterDataProvider>().saveFilters(i);
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
            (i, e) => MapEntry(
              i,
              _ItemFilter(
                isEnabled: e.isEnabled,
                title: e.title,
                assetName: e.assetName ?? 'null',
                onTap: () {
                  final filteredByType =
                      filtersTable.placeList.where((sight) => sight.placeType.contains(e.title)).toList();
                  if (!e.isEnabled) {
                    FilterDataProvider.filteredMocks.addAll(filteredByType);
                  } else {
                    FilterDataProvider.filteredMocks.clear();
                    FilterDataProvider.filtersWithDistance.clear();
                    debugPrint('🟡---------Добавленные места: ${FilterDataProvider.filteredMocks}');
                  }
                  context.read<FilterDataProvider>().showCount(placeList: placeList);

                  return context.read<FilterDataProvider>().saveFilters(i);
                },
              ),
            ),
          )
          .values
          .toList(),
    );
  }
}

class _ItemFilter extends StatefulWidget {
  final bool isEnabled;
  final Function() onTap;
  final String title;
  final String assetName;

  const _ItemFilter({
    Key? key,
    required this.isEnabled,
    required this.title,
    required this.assetName,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_ItemFilter> createState() => _ItemFilterState();
}

class _ItemFilterState extends State<_ItemFilter> {
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
                onTap: widget.onTap,
                child: SizedBox(
                  height: 64,
                  width: 64,
                  child: !widget.isEnabled
                      ? CircleAvatar(
                          backgroundColor: theme.canvasColor,
                          child: SightIcons(
                            assetName: widget.assetName,
                            width: 32,
                            height: 32,
                          ),
                        )
                      : Opacity(
                          opacity: 0.5,
                          child: CircleAvatar(
                            backgroundColor: theme.canvasColor,
                            child: SightIcons(
                              assetName: widget.assetName,
                              width: 32,
                              height: 32,
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall,
              ),
            ],
          ),
        ),
        if (widget.isEnabled)
          Positioned(
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
        else
          const SizedBox(),
      ],
    );
  }
}

class _DistanceSlider extends StatefulWidget {
  final List<Place> placeList;
  const _DistanceSlider({
    Key? key,
    required this.placeList,
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
              'от ${Mocks.rangeValues.start.toInt()} до ${Mocks.rangeValues.end.toInt()} м',
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: 24),
        RangeSlider(
          values: Mocks.rangeValues,
          min: min,
          max: max,
          onChanged: (values) {
            context.read<PlaceInteractor>().changeArea(start: values.start, end: values.end);
            context.read<FilterDataProvider>().showCount(placeList: widget.placeList);
          },
        ),
      ],
    );
  }
}
