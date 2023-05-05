import 'package:flutter/material.dart';
import 'package:places/ui/screens/navigation_screen/navigation_screen.dart';

import 'package:places/ui/screens/res/custom_colors.dart';

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
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return GestureDetector(
      onTap: () {
        debugPrint('🟡---------Back button pressed');
        Navigator.pop(context);
        // Navigator.of(context).push(
        //   MaterialPageRoute<NavigationScreen>(
        //     builder: (_) => const NavigationScreen(),
        //   ),
        // );
      },
      child: Container(
        width: height,
        height: width,
        decoration: BoxDecoration(
          color: customColors.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.chevron_left,
          size: 25,
        ),
      ),
    );
  }
}
