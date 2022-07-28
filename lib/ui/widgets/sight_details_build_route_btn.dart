import 'package:flutter/material.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/widgets/sight_details_button_icon.dart';

class SightDetailsBuildRouteBtn extends StatelessWidget {
  const SightDetailsBuildRouteBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromRGBO(76, 175, 80, 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SightDetailsGoButtonIcon(),
          const SizedBox(width: 8),
          Text(
            AppString.goButtonTitle.toUpperCase(),
            style: AppTypography.sightDetailsButtonName,
          ),
        ],
      ),
    );
  }
}
