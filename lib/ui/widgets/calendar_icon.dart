import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/app_assets.dart';

class CalendarIcon extends StatelessWidget {
  const CalendarIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.calendar,
      width: 22,
      height: 19,
    );
  }
}
