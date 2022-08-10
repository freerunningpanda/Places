import 'package:flutter/material.dart';

import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_card_size.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screen/res/app_theme.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/widgets/bottom_navigation_bar.dart';
import 'package:places/ui/widgets/sight_icons.dart';

List<Sight> list = Mocks.mocks;

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  // bool isDarkMode = false;
  int initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: const _AppBar(),
        body: Stack(
          children: [
            Column(
              children: [
                const _TabBarWidget(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: TabBarView(
                      children: [
                        if (list.isNotEmpty)
                          const _WantToVisitWidget()
                        else
                          const _EmptyList(
                            icon: AppAssets.card,
                            description: AppString.likedPlaces,
                          ),
                        if (list.isNotEmpty)
                          const _VisitedWidget()
                        else
                          const _EmptyList(
                            icon: AppAssets.goIconTransparent,
                            description: AppString.finishRoute,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Positioned(
              bottom: 16,
              left: 92,
              right: 92,
              child: _AddNewPlaceButton(),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavigationBarWidget(),
      ),
    );
  }
}

class _AddNewPlaceButton extends StatelessWidget {
  const _AddNewPlaceButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 177,
      height: 48,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: AppColors.limeGradient,
        ),
        borderRadius: BorderRadius.circular(30),
        color: Colors.green,
      ),
      child: Row(
        children: const [
          Expanded(child: SizedBox()),
          SightIcons(assetName: AppAssets.plus, width: 24, height: 24),
          SizedBox(width: 8),
          Text(
            AppString.addNewPlace,
            style: AppTypography.sightCardTitle,
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Size get preferredSize => const Size.fromHeight(45);

  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        AppString.visitingScreenTitle,
        // style: isDarkMode ? AppTypography.visitingScreenTitleDarkMode : AppTypography.visitingScreenTitle,
      ),
      elevation: 0,
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
        // color: isDarkMode ? AppColors.darkThemeSightCardColor : AppColors.sightCardBackground,
      ),
      child: TabBar(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          // color: isDarkMode ? AppColors.backgroundColor : AppColors.chevroneColor,
        ),
        // unselectedLabelColor: isDarkMode ? AppColors.secondaryTwo : AppColors.backgroundColor,
        tabs: [
          Tab(
            child: Text(
              AppString.tabBarOneText,
              // style: isDarkMode ? AppTypography.enabledTabDarkMode : AppTypography.sightCardTitle,
            ),
          ),
          Tab(
            child: Text(
              AppString.tabBarTwoText,
              // style: isDarkMode ? AppTypography.enabledTabDarkMode : AppTypography.sightCardTitle,
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
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = Mocks.mocks[index];

        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<SightDetails>(
              builder: (context) => SightDetails(
                // isDarkMode: isDarkMode,
                sight: item,
              ),
            ),
          ),
          child: SightCard(
            // isDarkMode: isDarkMode,
            url: item.url,
            type: item.type,
            name: item.name,
            aspectRatio: AppCardSize.visitingCard,
            details: [
              Text(
                item.name,
                maxLines: 2,
                // style: isDarkMode
                //     ? AppTypography.sightCardDescriptionTitleDarkMode
                //     : AppTypography.sightCardDescriptionTitle,
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
          ),
        );
      },
    );
  }
}

class _VisitedWidget extends StatelessWidget {
  const _VisitedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = Mocks.mocks[index];

        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<SightDetails>(
              builder: (context) => SightDetails(
                // isDarkMode: isDarkMode,
                sight: item,
              ),
            ),
          ),
          child: SightCard(
            // isDarkMode: isDarkMode,
            url: item.url,
            type: item.type,
            name: item.name,
            aspectRatio: AppCardSize.visitingCard,
            details: [
              Text(
                item.name,
                maxLines: 2,
                // style: isDarkMode
                //     ? AppTypography.sightCardDescriptionTitleDarkMode
                //     : AppTypography.sightCardDescriptionTitle,
              ),
              const SizedBox(height: 2),
              const Text(
                '${AppString.targetReach} 12 окт. 2022',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.detailsText,
              ),
              const SizedBox(height: 10),
              const Text(
                '${AppString.closed} 09:00',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.detailsText,
              ),
            ],
            actions: const [
              SightIcons(
                assetName: AppAssets.share,
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
          ),
        );
      },
    );
  }
}

class _EmptyList extends StatelessWidget {
  final String icon;
  final String description;
  const _EmptyList({
    Key? key,
    required this.icon,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SightIcons(
          assetName: icon,
          width: 64,
          height: 64,
        ),
        const SizedBox(height: 24),
        const Text(
          AppString.emptyList,
          style: AppTypography.emptyListTitle,
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 190,
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: AppTypography.emptyListSubTitle,
          ),
        ),
      ],
    );
  }
}
