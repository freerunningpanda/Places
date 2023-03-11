import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/cubits/places_list/places_list_cubit.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/screens/onboarding_screen/onboarding_screen.dart';
import 'package:places/ui/widgets/place_icons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late bool isInitialized;
  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    // _init();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _rotateAnimation = Tween<double>(begin: 0, end: -pi * 2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.decelerate),
    );

    _animationController
      ..forward()
      ..repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.splashScreenBackground,
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) => Transform.rotate(
              angle: _rotateAnimation.value,
              child: const PlaceIcons(
                assetName: AppAssets.subtract,
                width: 160,
                height: 160,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Метод инициализации данных
  Future<void> _init() async {
    isInitialized = false;

    /// изначально данные непроинициализированы.
    await _loadData();
    await _navigateToNext();
  }

  /// Метод загрузки данных
  Future<void> _loadData() async {
    await context.read<PlacesListCubit>().getPlaces();
    isInitialized = true;

    /// загрузка данных. isInitialized меняется на true.
  }

  /// Метод навигации
  Future<void> _navigateToNext() async {
    if (mounted && isInitialized) {
      /// если виджет смонтирован и проинициализирован, то переходим на OnBoardingScreen
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute<OnboardingScreen>(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    } else {
      return;

      /// иначе остаёмся на SplashScreen
    }
  }
}
