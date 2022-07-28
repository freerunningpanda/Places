import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/app_assets.dart';

class SightCardHeartIcon extends StatelessWidget {
  const SightCardHeartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.favourite,
      height: 24,
      width: 24,
    );
  }
}
