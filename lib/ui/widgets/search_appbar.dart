import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const SearchAppBar({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 16,
      centerTitle: true,
      title: Text(
        title,
        style: theme.textTheme.titleLarge,
      ),
      bottomOpacity: 0.0,
    );
  }
}
