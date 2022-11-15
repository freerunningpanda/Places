import 'package:flutter/material.dart';

import 'package:places/ui/screens/res/custom_colors.dart';

class CloseBottomSheet extends StatelessWidget {
  final double width;
  final double height;
  const CloseBottomSheet({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return GestureDetector(
      onTap: () {
        debugPrint('🟡---------Close button pressed');
        Navigator.pop(context);
      },
      child: Container(
        width: height,
        height: width,
        decoration: BoxDecoration(
          color: customColors.color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(
          Icons.close_rounded,
          size: 25,
        ),
      ),
    );
  }
}
