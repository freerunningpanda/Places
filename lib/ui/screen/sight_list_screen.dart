import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

import 'package:places/mocks.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screen/res/app_theme.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/widgets/sight_icons.dart';

class SightListScreen extends StatefulWidget {
  final bool isDarkMode;
  const SightListScreen({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  List<Sight> list = Mocks.mocks;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: widget.isDarkMode ? AppTheme.buildThemeDark() : AppTheme.buildTheme(),
      child: Scaffold(
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
                          isDarkMode: widget.isDarkMode,
                          sight: item,
                        ),
                      ),
                    ),
                    child: SightCard(
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
                          style: widget.isDarkMode
                              ? AppTypography.sightCardDescriptionTitleDarkMode
                              : AppTypography.sightCardDescriptionTitle,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.details,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.textText16Regular,
                        ),
                      ],
                      isDarkMode: widget.isDarkMode,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
