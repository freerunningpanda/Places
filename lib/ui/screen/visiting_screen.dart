import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_card_size.dart';

import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/widgets/sight_icons.dart';

class VisitingScreen extends StatelessWidget {
  const VisitingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            AppString.visitingScreenTitle,
            style: AppTypography.visitingScreenTitle,
          ),
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
        ),
        body: Column(
          children: const [
            _TabBarWidget(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: TabBarView(
                  children: [
                    _WantToVisitWidget(),
                    Text('data'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabBarWidget extends StatelessWidget {
  const _TabBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.sightCardBackground,
      ),
      child: TabBar(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.chevroneColor,
        ),
        labelColor: AppColors.backgroundColor,
        unselectedLabelColor: AppColors.subtitleTextColor,
        tabs: const [
          Tab(
            child: Text(
              AppString.tabBarOneText,
            ),
          ),
          Tab(
            child: Text(
              AppString.tabBarTwoText,
            ),
          ),
        ],
      ),
    );
  }
}

class _WantToVisitWidget extends StatelessWidget {
  const _WantToVisitWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mocks = Mocks.mocks;
    if (mocks.isEmpty) return const _EmptyList();

    return ListView.builder(
      itemCount: mocks.length,
      itemBuilder: (context, index) {
        final item = Mocks.mocks[index];

        return SightCard(
          url: item.url,
          type: item.type,
          name: item.name,
          aspectRatio: AppCardSize.visitingCard,
          details: [
            Text(
              item.name,
              maxLines: 2,
              style: AppTypography.sightCardDescriptionTitle,
            ),
            const SizedBox(height: 2),
            const Text(
              '${AppString.planning} 12 окт. 2022',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.greenColor,
            ),
            const SizedBox(height: 10),
            const Text(
              '${AppString.closed} 09:00',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.textText16Regular,
            ),
          ],
          actions: const [
            SightIcons(
              assetName: AppAssets.calendarWhite,
              width: 24,
              height: 24,
            ),
            SizedBox(width: 16),
            SightIcons(
              assetName: AppAssets.cross,
              width: 22,
              height: 22,
            ),
          ],
        );
      },
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SightIcons(
          assetName: AppAssets.goIconTransparent,
          width: 64,
          height: 64,
        ),
        SizedBox(height: 24),
        Text(
          AppString.emptyList,
          style: AppTypography.emptyListTitle,
        ),
        SizedBox(height: 8),
        SizedBox(
          width: 180,
          child: Text(
            AppString.finishRoute,
            textAlign: TextAlign.center,
            style: AppTypography.emptyListSubTitle,
          ),
        ),
      ],
    );
  }
}
