import 'package:flutter/material.dart';
import 'package:places/main.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/widgets/action_button.dart';
import 'package:places/ui/widgets/sight_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final pages = <Widget>[
      _OnboardingScreenContent(
        theme: theme,
        assetName: AppAssets.tutorial_1,
        title: AppString.welcome,
        description: AppString.findNewLoc,
      ),
      _OnboardingScreenContent(
        theme: theme,
        assetName: AppAssets.tutorial_2,
        title: AppString.routeBuild,
        description: AppString.reachYourTarget,
      ),
      _OnboardingScreenContent(
        key: UniqueKey(),
        theme: theme,
        assetName: AppAssets.tutorial_3,
        title: AppString.addYourPlaces,
        description: AppString.shareYourPlaces,
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 18,
          right: 16,
          bottom: 8,
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                  _controller.animateToPage(
                    _currentIndex,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linear,
                  );
                },
                controller: _controller,
                children: pages,
              ),
            ),
            SmoothPageIndicator(
              onDotClicked: (index) {
                setState(() {
                  _currentIndex = index;
                });
                _controller.animateToPage(
                  _currentIndex,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
              },
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: theme.sliderTheme.activeTrackColor as Color,
                dotColor: theme.sliderTheme.inactiveTrackColor as Color,
                dotWidth: 8,
                dotHeight: 8,
              ),
            ),
            if (_currentIndex == 2)
              Column(
                children: [
                  const SizedBox(height: 32),
                  ActionButton(
                    title: AppString.start,
                    onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute<MainScreen>(
                        builder: (context) => const MainScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              )
            else
              const SizedBox(height: 88),
          ],
        ),
      ),
    );
  }
}

class _OnboardingScreenContent extends StatelessWidget {
  final ThemeData theme;
  final String assetName;
  final String title;
  final String description;
  const _OnboardingScreenContent({
    Key? key,
    required this.theme,
    required this.assetName,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute<MainScreen>(
                  builder: (context) => const MainScreen(),
                ),
              ),
              child: Text(
                AppString.skip,
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 191),
        SightIcons(
          assetName: assetName,
          width: 104,
          height: 104,
        ),
        const SizedBox(height: 40),
        Center(
          child: SizedBox(
            width: 244,
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 117),
      ],
    );
  }
}
