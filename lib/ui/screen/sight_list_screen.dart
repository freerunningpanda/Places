import 'package:flutter/material.dart';

import 'package:places/mocks.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screen/sight_card.dart';

class SightListScreen extends StatelessWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = Mocks.mocks;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const _AppBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            width: double.infinity,
            height: 72,
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];

                return SightCard(
                  url: item.url,
                  type: item.type,
                  name: item.name,
                  details: item.details,
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
  Size get preferredSize => const Size(double.infinity, 64);

  const _AppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
