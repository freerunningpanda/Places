import 'package:flutter/material.dart';

import 'package:places/ui/res/app_colors.dart';

class ChevroneBack extends StatelessWidget {
  final double width;
  final double height;
  const ChevroneBack({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: height,
        height: width,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.chevron_left,
          color: AppColors.chevroneColor,
          size: 25,
        ),
      ),
    );
  }
}
