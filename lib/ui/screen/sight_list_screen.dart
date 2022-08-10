import 'package:flutter/material.dart';

import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/sight_details.dart';
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
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];

                return GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<SightDetails>(
                      builder: (context) => SightDetails(
                        sight: item,
                      ),
                    ),
                  ),
                  child: SightCard(
                    aspectRatio: 3/1.5,
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
                  ),
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
