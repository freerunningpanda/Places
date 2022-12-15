import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/widgets/sight_icons.dart';
import 'package:provider/provider.dart';

class SuffixIcon extends StatelessWidget {
  final TextEditingController controller;
  final ThemeData theme;

  const SuffixIcon({
    Key? key,
    required this.controller,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: () {
          controller.clear();
          context.read<PlaceInteractor>().searchPlaces('', controller);
        },
        child: SightIcons(
          assetName: AppAssets.clearDark,
          width: 20,
          height: 20,
          color: theme.iconTheme.color,
        ),
      ),
    );
  }
}
