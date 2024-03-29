import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/cubits/show_places_button/show_places_button_cubit.dart';
import 'package:places/data/model/category.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/res/custom_colors.dart';
import 'package:places/ui/widgets/place_icons.dart';

class ActionButton extends StatelessWidget {
  final String? assetName;
  final String title;
  final VoidCallback? onTap;
  final List<Category>? activeFilters;
  final RangeValues? rangeValues;
  final bool? isOnboarding;

  const ActionButton({
    Key? key,
    this.assetName,
    required this.title,
    required this.onTap,
    this.activeFilters,
    this.rangeValues,
    this.isOnboarding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = Theme.of(context).extension<CustomColors>();

    return BlocBuilder<ShowPlacesButtonCubit, ShowPlacesButtonState>(
      builder: (_, state) {
        return Stack(
          children: [
            Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: state.isEmpty && isOnboarding == null ? customColors?.color : theme.sliderTheme.activeTrackColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (assetName == null)
                    const SizedBox()
                  else
                    PlaceIcons(
                      assetName: assetName ?? AppAssets.goIcon,
                      width: 24,
                      height: 24,
                    ),
                  const SizedBox(width: 8),
                  if(isOnboarding == null)
                  Text(
                    '$title (${state.foundPlacesLength})',
                    style: state.isEmpty && isOnboarding == null
                        ? AppTypography.placeDetailsButtonNameInnactive
                        : AppTypography.placeDetailsButtonName,
                  )
                  else
                  Text(
                    title,
                    style: AppTypography.placeDetailsButtonName,
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.0),
                  onTap: state.isEmpty && isOnboarding == null ? null : onTap,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
