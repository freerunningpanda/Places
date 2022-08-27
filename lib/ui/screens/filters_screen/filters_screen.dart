import 'dart:math';

import 'package:flutter/material.dart';

import 'package:places/data/filters.dart';
import 'package:places/data/filters_table.dart';
import 'package:places/data/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/filters_screen/filters_settings.dart';
import 'package:places/ui/widgets/action_button.dart';
import 'package:places/ui/widgets/sight_icons.dart';
import 'package:provider/provider.dart';

// ignore: long-parameter-list
bool isNear({
  required double startingPointLat,
  required double startingPointLon,
  required double checkPointLat,
  required double checkPointLon,
  required int distance,
}) {
  var ky = 40000000 / 360;
  var kx = cos(pi * startingPointLat / 180) * ky;
  var dx = (startingPointLon - checkPointLon).abs() * kx;
  var dy = (startingPointLat - checkPointLat).abs() * ky;

  return sqrt(dx * dx + dy * dy) < distance;
}

class FilterScreen extends StatefulWidget {
  final List<Sight> sightList;
  final VoidCallback? onPressed;
  const FilterScreen({
    Key? key,
    required this.sightList,
    this.onPressed,
  }) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    final clearFilters = context.read<FiltersSettings>().clearAllFilters;

    return Scaffold(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Title(),
            const SizedBox(height: 24),
            _FiltersTable(
              sightList: widget.sightList,
              filters: FiltersTable.filters,
              activeFilters: FiltersSettings().activeFilters,
            ),
            const SizedBox(height: 60),
            Expanded(
              child: _DistanceSlider(
                rangeValues: Mocks.rangeValues,
                onChanged: getValues,
              ),
            ),
            ActionButton(
              activeFilters: FiltersSettings().activeFilters,
              title: '${AppString.showPlaces} (amount)',
              rangeValues: Mocks.rangeValues,
              onTap: () {
                debugPrint('🟡---------show places pressed');
                debugPrint('🟡---------Сохранённые значения фильтров: ${FiltersSettings().activeFilters}');
                debugPrint(
                  '🟡---------Сохранённое значение слайдера: min: ${Mocks.rangeValues.start.round()}, max: ${Mocks.rangeValues.end.round()}',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  RangeValues getValues(RangeValues values) {
    setState(() {
      Mocks.rangeValues = values;
    });

    return Mocks.rangeValues;
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
  final List<Filters> filters;
  final List<String> activeFilters;
  final List<Sight> sightList;
  const _FiltersTable({
    Key? key,
    required this.sightList,
    required this.filters,
    required this.activeFilters,
  }) : super(key: key);

  @override
  State<_FiltersTable> createState() => _FiltersTableState();
}

class _FiltersTableState extends State<_FiltersTable> {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_statements
    context.watch<FiltersSettings>();

    return Container(
      alignment: const Alignment(0.0, -0.8),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 24,
        runSpacing: 40,
        children: widget.filters
            .asMap()
            .map(
              (i, e) => MapEntry(
                i,
                _ItemFilter(
                  isEnabled: e.isEnabled,
                  title: e.title,
                  assetName: e.assetName,
                  onTap: () {
                    isNear(
                      startingPointLat: Mocks.mockLat,
                      startingPointLon: Mocks.mockLot,
                      checkPointLat: widget.sightList[i].lat,
                      checkPointLon: widget.sightList[i].lon,
                      distance: 1,
                    );

                    return context.read<FiltersSettings>().saveFilters(i);
                  },
                ),
              ),
            )
            .values
            .toList(),
      ),
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

    final height = MediaQuery.of(context).size.height / 6;

    return Stack(
      children: [
        SizedBox(
          width: 98,
          height: height,
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
            bottom: 48,
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
  final void Function(RangeValues)? onChanged;
  final RangeValues rangeValues;
  const _DistanceSlider({
    Key? key,
    required this.rangeValues,
    required this.onChanged,
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
              'от ${widget.rangeValues.start.toInt()} до ${widget.rangeValues.end.toInt()} м',
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: 24),
        RangeSlider(
          values: widget.rangeValues,
          min: min,
          max: max,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
