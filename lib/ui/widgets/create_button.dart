import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/cubits/create_place/create_place_button_cubit.dart';

import 'package:places/data/model/category.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/res/custom_colors.dart';
import 'package:places/ui/widgets/sight_icons.dart';

class CreateButton extends StatelessWidget {
  final String? assetName;
  final String title;
  final VoidCallback? onTap;
  final List<String>? activeFilters;
  final RangeValues? rangeValues;
  // final TextEditingController titleController;
  // final TextEditingController latController;
  // final TextEditingController lotController;
  // final TextEditingController descriptionController;
  // final List<Category> chosenCategory;

  const CreateButton({
    Key? key,
    this.assetName,
    required this.title,
    required this.onTap,
    this.activeFilters,
    this.rangeValues,
    // required this.titleController,
    // required this.latController,
    // required this.lotController,
    // required this.descriptionController,
    // required this.chosenCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = Theme.of(context).extension<CustomColors>();

    return BlocBuilder<CreatePlaceButtonCubit, CreatePlaceButtonState>(
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: buttonStyle(state: state) ? customColors?.color : theme.sliderTheme.activeTrackColor,
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
                    style: buttonStyle(state: state)
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
                  onTap: buttonStyle(state: state) ? null : onTap,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  bool buttonStyle({required CreatePlaceButtonState state}) {
    return state.chosenCategory.isEmpty ||
        state.titleValue.isEmpty ||
        state.descriptionValue.isEmpty ||
        state.latValue.isEmpty ||
        state.lotValue.isEmpty;
  }
}
