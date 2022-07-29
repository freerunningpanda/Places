import 'package:flutter/material.dart';

import 'package:places/mocks.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/sight_details.dart';

class SightListScreen extends StatelessWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = Mocks.mocks;

    return Scaffold(
      backgroundColor: Colors.white,
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
                        sight: list[index],
                      ),
                    ),
                  ),
                  child: SightCard(
                    url: item.url,
                    type: item.type,
                    name: item.name,
                    details: item.details,
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
        'Список \nинтересных мест',
        style: AppTypography.appBarTitle,
      ),
      backgroundColor: Colors.white,
      bottomOpacity: 0.0,
      elevation: 0,
    );
  }
}
