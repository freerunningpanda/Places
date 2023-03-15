import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/cubits/create_place/create_place_button_cubit.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/res/custom_colors.dart';
import 'package:places/ui/widgets/place_icons.dart';

class CreateButton extends StatelessWidget {
  final String? assetName;
  final String title;
  final VoidCallback? onTap;
  final List<String>? activeFilters;
  final RangeValues? rangeValues;

  const CreateButton({
    Key? key,
    this.assetName,
    required this.title,
    required this.onTap,
    this.activeFilters,
    this.rangeValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = Theme.of(context).extension<CustomColors>();

    return BlocBuilder<CreatePlaceButtonCubit, CreatePlaceButtonState>(
      builder: (_, state) {
        final buttonStyle = context.read<CreatePlaceButtonCubit>().buttonStyle(state: state);

        return Stack(
          children: [
            Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: buttonStyle ? customColors?.color : theme.sliderTheme.activeTrackColor,
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
                  Text(
                    title,
                    style: buttonStyle
                        ? AppTypography.placeDetailsButtonNameInnactive
                        : AppTypography.placeDetailsButtonName,
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.0),
                  onTap: buttonStyle ? null : onTap,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
