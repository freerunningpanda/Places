import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:places/isolate.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/screens/onboarding_screen/onboarding_screen.dart';
import 'package:places/ui/widgets/sight_icons.dart';

void isolateLoop(SendPort sendPort) {
  Future(() {
    final list = List<String>.generate(10000, (index) => 'Some string');
    final reversedList = <String>[];
    // 2
    for (var i = 0; i < list.length; i++) {
      reversedList.addAll([list[i].split('').reversed.join()]);
      debugPrint('🟡--------- $reversedList');
      sendPort.send(true);
    }
  });
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool isInitialized;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    startIsolateLoop();
    
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.splashScreenBackground,
        ),
      ),
      child: Center(
        child: SightIcons(
          assetName: AppAssets.subtract,
          width: 160,
          height: 160,
        ),
      ),
    );
  }

  /// Метод инициализации данных
  Future<void> _init() async {
    isInitialized = false;

    /// изначально данные непроинициализированы.
    await _loadData();
    await _navigateToNext();
  }

  /// Метод загрузки данных
  Future<void> _loadData() {
    // 3
    // Синхронный способ
    _syncLoop();
    // Внутри Future
    _futureLoop();
    // Внутри Isolate

    return Future.delayed(
      const Duration(seconds: 2),
      () => isInitialized = true,

      /// загрузка данных. isInitialized меняется на true.
    );
  }

  void _syncLoop() {
    final list = List<String>.generate(10000, (index) => 'Some string'); // 1
    final reversedList = <String>[];
    // 2
    for (var i = 0; i < list.length; i++) {
      reversedList.addAll([list[i].split('').reversed.join()]); // 2.1
      debugPrint('🟡--------- $reversedList'); // 2.2
    }
  }

  void _futureLoop() {
    Future(() {
      final list = List<String>.generate(10000, (index) => 'Some string');
      final reversedList = <String>[];
      // 2
      for (var i = 0; i < list.length; i++) {
        reversedList.addAll([list[i].split('').reversed.join()]);
        debugPrint('🟡--------- $reversedList');
      }
    });
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
