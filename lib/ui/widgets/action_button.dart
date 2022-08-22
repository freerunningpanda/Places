import 'package:flutter/material.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/widgets/sight_icons.dart';

class ActionButton extends StatelessWidget {
  final String? assetName;
  final String title;
  final void Function()? onTap;
  final List<String>? activeFilters;
  final RangeValues? rangeValues;

  const ActionButton({
    Key? key,
    this.assetName,
    required this.title,
    required this.onTap,
    this.activeFilters,
    this.rangeValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.green,
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
              style: AppTypography.sightDetailsButtonName,
            ),
          ],
        ),
      ),
    );
  }
}
