import 'package:flutter/material.dart';
import 'package:places/ui/res/app_strings.dart';

class AddSightScreen extends StatelessWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 4.5;
    final theme = Theme.of(context);
    final cancel = GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Text(
        AppString.cancel,
        style: theme.textTheme.displayLarge,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 18, right: 16.0),
          child: _NewPlaceAppBar(
            theme: theme,
            width: width,
            leading: cancel,
          ),
        ),
      ),
    );
  }
}

class _NewPlaceAppBar extends StatelessWidget {
  final ThemeData theme;
  final double width;
  final Widget leading;
  const _NewPlaceAppBar({
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
