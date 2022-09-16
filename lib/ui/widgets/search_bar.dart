import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/appsettings.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/filters_screen/filters_screen.dart';
import 'package:places/ui/screens/res/custom_colors.dart';
import 'package:places/ui/screens/sight_search_screen.dart/sight_search_screen.dart';
import 'package:places/ui/widgets/sight_icons.dart';
import 'package:places/ui/widgets/suffix_icon.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  final bool? readOnly;
  final bool isSearchPage;

  const SearchBar({
    Key? key,
    this.readOnly,
    required this.isSearchPage,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();

  bool autofocus = true;

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);
    final suggestions = context.read<AppSettings>().suggestions;

    context.watch<AppSettings>();

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 30.0,
        right: 16.0,
        bottom: 34,
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: customColors.color,
        ),
        child: Row(
          children: [
            const SightIcons(
              assetName: AppAssets.search,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp('[ ]')),
                ],
                style: theme.textTheme.bodyLarge,
                textCapitalization: TextCapitalization.sentences,
                controller: controller,
                autofocus: autofocus,
                focusNode: focusNode,
                readOnly: widget.readOnly ?? true,
                onChanged: (value) {
                  context.read<AppSettings>()
                    ..activeFocus(isActive: true)
                    ..searchSight(value, controller);

                  if (controller.text.isEmpty) {
                    suggestions.clear();
                  }
                },
                onTap: () {
                  context.read<AppSettings>().activeFocus(isActive: true);
                  if (!widget.isSearchPage) {
                    Navigator.of(context).push(
                      MaterialPageRoute<SightSearchScreen>(
                        builder: (context) => const SightSearchScreen(),
                      ),
                    );
                  } else {
                    return;
                  }
                },
                onSubmitted: (value) {
                  context.read<AppSettings>()
                    ..activeFocus(isActive: false)
                    ..saveSearchHistory(value, controller);
                  controller.clear();
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIconConstraints: const BoxConstraints(
                    maxWidth: 24,
                    maxHeight: 24,
                  ),
                  hintText: 'Поиск',
                  hintStyle: AppTypography.textText16Search,
                  suffixIcon: focusNode.hasFocus
                      ? SuffixIcon(controller: controller, theme: theme)
                      : IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<FilterScreen>(
                                builder: (context) => const FilterScreen(),
                              ),
                            );
                            debugPrint('🟡---------filters button pressed');
                          },
                          icon: const SightIcons(assetName: AppAssets.filter, width: 24, height: 24),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
