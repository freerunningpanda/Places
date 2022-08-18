import 'package:flutter/material.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/widgets/sight_icons.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 24,
          right: 16,
          bottom: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _Title(),
            SizedBox(height: 24),
            _FiltersTable(),
            SizedBox(height: 60),
            _DistanceSlider(),
          ],
        ),
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
  @override
  Size get preferredSize => const Size.fromHeight(80); // Это свойство не применяется

  const _AppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: AppBar(
        leading: IconButton(
          onPressed: () {
            debugPrint('chevrone back pressed');
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left),
          color: Theme.of(context).iconTheme.color,
        ),
        toolbarHeight: 86,
        bottomOpacity: 0.0,
        actions: const [
          _ClearButtonWidget(),
        ],
      ),
    );
  }
}

class _ClearButtonWidget extends StatelessWidget {
  const _ClearButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        debugPrint('clear Button pressed');
      },
      child: const Text(
        AppString.clear,
        style: AppTypography.clearButton,
      ),
    );
  }
}

class _FiltersTable extends StatefulWidget {
  const _FiltersTable({Key? key}) : super(key: key);

  @override
  State<_FiltersTable> createState() => _FiltersTableState();
}

class _FiltersTableState extends State<_FiltersTable> {
  final Map<String, String> filters = {
    AppString.hotel: AppAssets.hotel,
    AppString.restaurant: AppAssets.restaurant,
    AppString.particularPlace: AppAssets.particularPlace,
    AppString.park: AppAssets.park,
    AppString.museum: AppAssets.museum,
    AppString.cafe: AppAssets.cafe,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0.0, -0.8),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 24,
        runSpacing: 40,
        children: filters.entries
            .map(
              (entry) => _ItemFilter(
                title: entry.key,
                assetName: entry.value,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ItemFilter extends StatefulWidget {
  final String title;
  final String assetName;
  const _ItemFilter({
    Key? key,
    required this.title,
    required this.assetName,
  }) : super(key: key);

  @override
  State<_ItemFilter> createState() => _ItemFilterState();
}

class _ItemFilterState extends State<_ItemFilter> {
  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          isEnabled = !isEnabled;
        });
      },
      child: Stack(
        children: [
          SizedBox(
            width: 98,
            height: 96,
            child: Column(
              children: [
                SizedBox(
                  height: 64,
                  width: 64,
                  child: !isEnabled
                      ? CircleAvatar(
                          backgroundColor: Theme.of(context).canvasColor,
                          child: SightIcons(
                            assetName: widget.assetName,
                            width: 32,
                            height: 32,
                          ),
                        )
                      : Opacity(
                          opacity: 0.5,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).canvasColor,
                            child: SightIcons(
                              assetName: widget.assetName,
                              width: 32,
                              height: 32,
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
          if (isEnabled)
            Positioned(
              right: 16,
              bottom: 30,
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
      ),
    );
  }
}

class _DistanceSlider extends StatefulWidget {
  const _DistanceSlider({Key? key}) : super(key: key);

  @override
  State<_DistanceSlider> createState() => _DistanceSliderState();
}

class _DistanceSliderState extends State<_DistanceSlider> {
  RangeValues values = const RangeValues(2000, 8000);
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
              'от ${values.start.toInt()} до ${values.end.toInt()} м',
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: 24),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 1,
            inactiveTrackColor: AppColors.inactiveBlack,
            activeTrackColor: AppColors.green,
            thumbColor: AppColors.backgroundColor,
            overlayShape: SliderComponentShape.noOverlay,
            rangeThumbShape: const RoundRangeSliderThumbShape(
              elevation: 3,
            ),
          ),
          child: RangeSlider(
            values: values,
            min: min,
            max: max,
            onChanged: (values) => setState(
              () => this.values = values,
            ),
          ),
        ),
      ],
    );
  }
}
