import 'package:flutter/material.dart';

import 'package:places/ui/res/app_colors.dart';

class ChevroneBack extends StatelessWidget {
  final double width;
  final double height;
  final bool isDarkMode;
  const ChevroneBack({
    Key? key,
    required this.height,
    required this.width,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: height,
        height: width,
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.darkThemeBgColor : AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.chevron_left,
          color: isDarkMode ? AppColors.backgroundColor : AppColors.chevroneColor,
          size: 25,
        ),
      ),
    );
  }
}
