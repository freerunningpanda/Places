import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/app_assets.dart';

class SightCardDarkHeartIcon extends StatelessWidget {
  const SightCardDarkHeartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.favouriteDark,
      width: 20,
      height: 18,
    );
  }
}
