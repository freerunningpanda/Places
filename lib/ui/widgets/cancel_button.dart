import 'package:flutter/material.dart';
import 'package:places/ui/res/app_strings.dart';

import 'package:places/ui/res/app_typography.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Container(
          height: 48,
          width: 328,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: theme.sliderTheme.thumbColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const SizedBox(width: 8),
              Text(
                AppStrings.cancel.toUpperCase(),
                style: AppTypography.cancelButtonStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
