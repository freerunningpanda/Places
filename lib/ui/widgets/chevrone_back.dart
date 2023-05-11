import 'package:flutter/material.dart';
import 'package:places/ui/screens/navigation_screen/navigation_screen.dart';

import 'package:places/ui/screens/res/custom_colors.dart';

class ChevroneBack extends StatelessWidget {
  final double width;
  final double height;
  final bool fromMainScreen;
  const ChevroneBack({
    Key? key,
    required this.height,
    required this.width,
    required this.fromMainScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return GestureDetector(
      onTap: () {
        debugPrint('🟡---------Back button pressed');
        // Navigator.pop(context);
        // Плохое решение, позиция скролла будет теряться каждый раз при возврате с экрана детализации места
        // Из-за постоянной перестройки виджета
        // Сделано ради обновления состояния лайков на экране интересных мест, поставленных на экране детализации
        // Не нашёл способа как это сделать сделать через менеджеры состояний
        if (fromMainScreen) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<NavigationScreen>(
              builder: (_) => const NavigationScreen(),
            ),
          );
        } else {
          Navigator.pop(context);
        }
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
