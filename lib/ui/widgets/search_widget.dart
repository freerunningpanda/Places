import 'package:flutter/material.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/filters_screen/filters_screen.dart';
import 'package:places/ui/screens/res/custom_colors.dart';
import 'package:places/ui/widgets/sight_icons.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

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
                onTap: () {
                  debugPrint('🟡---------on textfield pressed');
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIconConstraints: const BoxConstraints(
                    maxWidth: 24,
                    maxHeight: 24,
                  ),
                  hintText: 'Поиск',
                  hintStyle: AppTypography.textText16Search,
                  suffixIcon: IconButton(
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