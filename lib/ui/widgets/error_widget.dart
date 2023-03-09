import 'package:flutter/material.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/widgets/place_icons.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          PlaceIcons(
            assetName: AppAssets.error,
            width: 64,
            height: 64,
          ),
          SizedBox(height: 24),
          Text(
            AppString.error,
            textAlign: TextAlign.center,
            style: AppTypography.emptyListTitle,
          ),
          SizedBox(height: 8),
          Text(
            AppString.errorDescription,
            textAlign: TextAlign.center,
            style: AppTypography.detailsTextDarkMode,
          ),
        ],
      ),
    );
  }
}