import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:places/cubits/places_list/places_list_cubit.dart';
import 'package:places/data/store/app_preferences.dart';
import 'package:places/main.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/screens/navigation_screen/navigation_screen.dart';
import 'package:places/ui/screens/onboarding_screen/onboarding_screen.dart';
import 'package:places/ui/widgets/place_icons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  bool isFirstOpen = AppPreferences.getTheFirstOpen();
  late bool isInitialized;
  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    _init();
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
            builder: (_, child) => Transform.rotate(
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
    if (status.isDenied) {
      await context.read<PlacesListCubit>().getPlacesNoGeo();
    } else if (status.isGranted) {
      await context.read<PlacesListCubit>().getPlaces();
    }
    isInitialized = true;

    /// загрузка данных. isInitialized меняется на true.
  }


  /// Метод навигации
  Future<void> _navigateToNext() async {
    /// если виджет смонтирован и проинициализирован, то переходим
    /// Если первый запуск приложения на OnBoardingScreen
    /// Если второй то NavigationScreen
    if (mounted && isInitialized) {
      if (isFirstOpen) {
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute<OnboardingScreen>(
            builder: (_) => const NavigationScreen(),
          ),
        );
      } else {
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute<OnboardingScreen>(
            builder: (_) => const OnboardingScreen(),
          ),
        );
        await AppPreferences.setTheFirstOpen(value: isFirstOpen = true);
      }
    } else {
      return;

      /// иначе остаёмся на SplashScreen
    }
  }
}
