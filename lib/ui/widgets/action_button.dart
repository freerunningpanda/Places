import 'package:flutter/material.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/res/custom_colors.dart';
import 'package:places/ui/widgets/sight_icons.dart';

class ActionButton extends StatelessWidget {
  final String? assetName;
  final String title;
  final VoidCallback? onTap;
  final List<String>? activeFilters;
  final RangeValues? rangeValues;
  final int? counterValue;

  const ActionButton({
    Key? key,
    this.assetName,
    required this.title,
    required this.onTap,
    this.activeFilters,
    this.rangeValues,
    this.counterValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = Theme.of(context).extension<CustomColors>();

    return Stack(
      children: [
        Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: counterValue == 0 ? customColors?.color : theme.sliderTheme.activeTrackColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (assetName == null)
                const SizedBox()
              else
                SightIcons(
                  assetName: assetName ?? AppAssets.goIcon,
                  width: 24,
                  height: 24,
                ),
              const SizedBox(width: 8),
              Text(
                title,
                style: counterValue == 0
                    ? AppTypography.sightDetailsButtonNameInnactive
                    : AppTypography.sightDetailsButtonName,
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
