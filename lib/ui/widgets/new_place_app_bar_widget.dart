import 'package:flutter/material.dart';

class NewPlaceAppBarWidget extends StatelessWidget {
  final ThemeData theme;
  final double width;
  final Widget leading;
  final String title;
  const NewPlaceAppBarWidget({
    Key? key,
    required this.theme,
    required this.width,
    required this.leading,
    required this.title,
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
          title,
          style: theme.textTheme.titleLarge,
        ),
      ],
    );
  }
}
