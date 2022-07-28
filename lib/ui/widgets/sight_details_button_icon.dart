import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/app_assets.dart';

class SightDetailsGoButtonIcon extends StatelessWidget {
  const SightDetailsGoButtonIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.goIcon,
      width: 24,
      height: 24,
    );
  }
}
