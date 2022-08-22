import 'package:flutter/material.dart';

import 'package:places/data/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/filters_screen/filters_screen.dart';
import 'package:places/ui/screens/res/custom_colors.dart';
import 'package:places/ui/screens/sight_card/sight_card.dart';
import 'package:places/ui/widgets/sight_icons.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  List<Sight> list = Mocks.mocks;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 64),
          const _AppBar(),
          const _SearchWidget(),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];

                return SightCard(
                  aspectRatio: 3 / 1.5,
                  actions: const [
                    SightIcons(
                      assetName: AppAssets.favourite,
                      width: 22,
                      height: 22,
                    ),
                  ],
                  url: item.url,
                  type: item.type,
                  name: item.name,
                  item: item,
                  details: [
                    Text(
                      item.name,
                      maxLines: 2,
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      '${AppString.closed} 20:00',
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.textText16Regular,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(0); // Это свойство не применяется

  const _AppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 86,
      title: const Text(
        AppString.appTitle,
      ),
      bottomOpacity: 0.0,
    );
  }
}

class _SearchWidget extends StatefulWidget {
  const _SearchWidget({Key? key}) : super(key: key);

  @override
  State<_SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<_SearchWidget> {
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
                  debugPrint('on textfield pressed');
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
                      debugPrint('filters button pressed');
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
