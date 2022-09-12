import 'package:flutter/material.dart';

import 'package:places/data/sight.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/filters_screen/filters_screen.dart';
import 'package:places/ui/screens/res/custom_colors.dart';
import 'package:places/ui/widgets/sight_icons.dart';
import 'package:places/ui/widgets/suffix_icon.dart';

class SearchBar extends StatefulWidget {
  final List<Sight> sightList;
  final bool? readOnly;
  final bool isEnabled;

  const SearchBar({
    Key? key,
    required this.isEnabled,
    required this.sightList,
    this.readOnly,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();

  bool hasFocus = false;
  bool autofocus = true;

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);

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
                controller: controller,
                autofocus: autofocus,
                enabled: widget.isEnabled,
                focusNode: focusNode,
                readOnly: widget.readOnly ?? true,
                onChanged: (value) {
                  setState(() {});
                },
                onTap: () {
                  setState(() {
                    hasFocus = true;
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    hasFocus = false;
                  });
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
                                builder: (context) => FilterScreen(sightList: widget.sightList),
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
