import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/choose_category_bloc/choose_category_bloc.dart';

import 'package:places/data/model/category.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/res/custom_colors.dart';
import 'package:places/ui/widgets/place_icons.dart';

class SaveButton extends StatelessWidget {
  final String? assetName;
  final String title;
  final VoidCallback? onTap;
  final List<Category> chosenCategory;

  const SaveButton({
    Key? key,
    this.assetName,
    required this.title,
    required this.onTap,
    required this.chosenCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = Theme.of(context).extension<CustomColors>();

    return BlocBuilder<ChooseCategoryBloc, ChooseCategoryState>(
      builder: (_, state) {
        return Stack(
          children: [
            Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: state.isEmpty ? customColors?.color : theme.sliderTheme.activeTrackColor,
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
                    style: state.isEmpty
                        ? AppTypography.placeDetailsButtonNameInnactive
                        : AppTypography.placeDetailsButtonName,
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Material(
                type: MaterialType.transparency,
                child: state.isEmpty
                    ? null
                    : InkWell(
                        borderRadius: BorderRadius.circular(12.0),
                        onTap: onTap,
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
