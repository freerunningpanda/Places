import 'package:flutter/material.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/add_place_screen/add_place_screen.dart';
import 'package:places/ui/widgets/sight_icons.dart';

class AddNewPlaceButton extends StatelessWidget {
  const AddNewPlaceButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push<AddSightScreen>(
          MaterialPageRoute(
            builder: (context) => const AddSightScreen(),
          ),
        );
        debugPrint('🟡---------Add new place button pressed');
      },
      child: Container(
        width: 177,
        height: 48,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: AppColors.limeGradient,
          ),
          borderRadius: BorderRadius.circular(30),
          color: Colors.green,
        ),
        child: Row(
          children: const [
            Expanded(child: SizedBox()),
            PlaceIcons(assetName: AppAssets.plus, width: 24, height: 24),
            SizedBox(width: 8),
            Text(
              AppString.addNewPlace,
              style: AppTypography.sightCardTitle,
            ),
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
