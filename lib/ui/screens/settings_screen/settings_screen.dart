import 'package:flutter/material.dart';

import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/widgets/bottom_navigation_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const _AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          top: 32.0,
          right: 16.0,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  AppString.darkTheme,
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Text(
                  AppString.tutorial,
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        AppString.settings,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
