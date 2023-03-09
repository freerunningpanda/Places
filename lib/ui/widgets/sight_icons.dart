import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class PlaceIcons extends StatelessWidget {
  final String assetName;
  final double width;
  final double height;
  final Color? color;
  const PlaceIcons({
    Key? key,
    required this.assetName,
    required this.width,
    required this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      theme: SvgTheme(currentColor: color),
    );
  }
}
