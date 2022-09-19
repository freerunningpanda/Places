import 'package:flutter/material.dart';
import 'package:places/ui/res/app_strings.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const SearchAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      toolbarHeight: 16,
      centerTitle: true,
      title: Text(
        AppString.appTitle,
        style: theme.textTheme.titleLarge,
      ),
      bottomOpacity: 0.0,
    );
  }
}
