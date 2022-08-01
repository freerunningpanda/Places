import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_card_size.dart';

import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/widgets/sight_icons.dart';

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
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
          bottom: const TabBar(
            indicatorColor: Colors.transparent,
            tabs: [
              Tab(
                child: Text(
                  AppString.tabBarOneText,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  AppString.tabBarTwoText,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          _WantToVisitWidget(),
          Text('data'),
        ]),
      ),
    );
  }
}

class _WantToVisitWidget extends StatelessWidget {
  const _WantToVisitWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Mocks.mocks.length,
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
