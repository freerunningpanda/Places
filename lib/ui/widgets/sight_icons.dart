import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class SightIcons extends StatelessWidget {
  final String assetName;
  final double width;
  final double height;
  final Color? color;
  final void Function()? onTap;
  const SightIcons({
    Key? key,
    required this.assetName,
    required this.width,
    required this.height,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      color: color,
    );
  }
}
