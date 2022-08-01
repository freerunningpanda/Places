import 'package:flutter/material.dart';
import 'package:places/ui/res/app_assets.dart';

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
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: TabBarView(children: [
            SightCard(
              actions: [
                SightIcons(
                  assetName: AppAssets.favourite,
                  width: 22,
                  height: 22,
                ),
                SightIcons(
                  assetName: AppAssets.favourite,
                  width: 22,
                  height: 22,
                ),
              ],
              url: 'https://img.youtube.com/vi/2AphasZ9Hs0/0.jpg',
              type: 'type',
              name: 'name',
              details: 'details',
            ),
            Center(
              child: Text('data 2'),
            ),
          ]),
        ),
      ),
    );
  }
}

// class WantToVisit extends SightCard {
//   const WantToVisit({
//     Key? key,
//     required String url,
//     required String type,
//     required String name,
//     required String details,
//   }) : super(key: key, url: url, type: type, name: name, details: details);
// }
