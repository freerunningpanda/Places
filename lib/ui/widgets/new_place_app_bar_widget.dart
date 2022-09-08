import 'package:flutter/material.dart';

import 'package:places/ui/res/app_strings.dart';

class NewPlaceAppBarWidget extends StatelessWidget {
  final ThemeData theme;
  final double width;
  final Widget leading;
  const NewPlaceAppBarWidget({
    Key? key,
    required this.theme,
    required this.width,
    required this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leading,
        SizedBox(
          width: width,
        ),
        Text(
          AppString.newPlace,
          style: theme.textTheme.titleLarge,
        ),
      ],
    );
  }
}