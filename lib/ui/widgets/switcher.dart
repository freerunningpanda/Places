import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:provider/provider.dart';

class Switcher extends StatefulWidget {
  const Switcher({Key? key}) : super(key: key);

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  @override
  Widget build(BuildContext context) {
    final isSwitched = context.watch<PlaceInteractor>().isDarkMode;

    final theme = Theme.of(context);

    return CupertinoSwitch(
      activeColor: theme.sliderTheme.activeTrackColor,
      trackColor: theme.sliderTheme.inactiveTrackColor,
      value: isSwitched,
      onChanged: (value) {
        context.read<PlaceInteractor>().switchTheme(value: value);
      },
    );
  }
}
