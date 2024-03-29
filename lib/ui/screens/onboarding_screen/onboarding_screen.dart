import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/app.dart';

import 'package:places/providers/theme_data_provider.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screens/navigation_screen/navigation_screen.dart';
import 'package:places/ui/widgets/action_button.dart';
import 'package:places/ui/widgets/place_icons.dart';
import 'package:provider/provider.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final isDarkMode = context.watch<ThemeDataProvider>().isDarkMode;
    final theme = Theme.of(context);

    final pages = <Widget>[
      _OnboardingScreenContent(
        theme: theme,
        assetName: !isDarkMode ? AppAssets.tutorial_1 : AppAssets.tutorial_1Dark,
        title: AppStrings.welcome,
        description: AppStrings.findNewLoc,
      ),
      _OnboardingScreenContent(
        theme: theme,
        assetName: !isDarkMode ? AppAssets.tutorial_2 : AppAssets.tutorial_2Dark,
        title: AppStrings.routeBuild,
        description: AppStrings.reachYourTarget,
      ),
      _OnboardingScreenContent(
        key: UniqueKey(),
        theme: theme,
        assetName: !isDarkMode ? AppAssets.tutorial_3 : AppAssets.tutorial_3Dark,
        title: AppStrings.addYourPlaces,
        description: AppStrings.shareYourPlaces,
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
                    isOnboarding: true,
                    title: AppStrings.start,
                    onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute<MainScreen>(
                        builder: (_) => const NavigationScreen(fromMapScreen: false),
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

class _OnboardingScreenContent extends StatefulWidget {
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
  State<_OnboardingScreenContent> createState() => _OnboardingScreenContentState();
}

class _OnboardingScreenContentState extends State<_OnboardingScreenContent> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _zoomAnimation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _zoomAnimation = Tween<double>(begin: 0, end: 104).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    _animationController.forward();
    super.initState();
  }

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
                  builder: (_) => const NavigationScreen(fromMapScreen: false),
                ),
              ),
              child: Text(
                AppStrings.skip,
                style: widget.theme.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 191),
        AnimatedBuilder(
          animation: _animationController,
          builder: (_, child) => PlaceIcons(
            assetName: widget.assetName,
            width: _zoomAnimation.value,
            height: _zoomAnimation.value,
          ),
        ),
        const SizedBox(height: 40),
        Center(
          child: SizedBox(
            width: 244,
            child: Column(
              children: [
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: widget.theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  style: widget.theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 117),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
