import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Switcher extends StatefulWidget {
  const Switcher({Key? key}) : super(key: key);

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CupertinoSwitch(
      activeColor: theme.sliderTheme.activeTrackColor,
      trackColor: theme.sliderTheme.inactiveTrackColor,
      value: isSwitched,
      onChanged: (value) => setState(
        () => isSwitched = value,
      ),
    );
  }
}
