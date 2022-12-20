import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/providers/theme_data_provider.dart';

import 'package:provider/provider.dart';

class Switcher extends StatefulWidget {
  const Switcher({Key? key}) : super(key: key);

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  @override
  Widget build(BuildContext context) {
    final isSwitched = SettingsInteractor(
      darkModeProvider: ThemeDataProvider(),
    ).switchTheme(value: context.watch<ThemeDataProvider>().isDarkMode);

    final theme = Theme.of(context);

    return CupertinoSwitch(
      activeColor: theme.sliderTheme.activeTrackColor,
      trackColor: theme.sliderTheme.inactiveTrackColor,
      value: isSwitched,
      onChanged: (value) {
        context.read<ThemeDataProvider>().switchTheme(value: value);
      },
    );
  }
}
