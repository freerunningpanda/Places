import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide ErrorWidget;

import 'package:places/data/model/place.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/widgets/place_icons.dart';

class PlaceDetails extends StatefulWidget {
  final Place place;
  final double height;
  const PlaceDetails({
    Key? key,
    required this.place,
    required this.height,
  }) : super(key: key);

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const _PlaceDetailsImage(
      image: '',
      height: 300,
    );
  }
}

class _PlaceDetailsImage extends StatefulWidget {
  final String image;
  final double height;
  const _PlaceDetailsImage({
    Key? key,
    required this.image,
    required this.height,
  }) : super(key: key);

  @override
  State<_PlaceDetailsImage> createState() => _PlaceDetailsImageState();
}

class _PlaceDetailsImageState extends State<_PlaceDetailsImage> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _rotateAnimation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _rotateAnimation = Tween<double>(begin: 0, end: -pi * 5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    _animationController
      ..forward()
      ..repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 200,
        child: Hero(
          tag: 'tag',
          child: CachedNetworkImage(
            width: 200,
            imageUrl: 'https://gazo.ru/upload/iblock/3ff/3ff3fbd5c63139765de789ed11f64ebe.png',
            // fit: BoxFit.cover,
            errorWidget: (context, url, dynamic error) => Image.asset(AppAssets.placeholder),
            progressIndicatorBuilder: (context, url, progress) => AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Center(
                  child: Transform.rotate(
                    angle: _rotateAnimation.value,
                    child: const PlaceIcons(
                      assetName: AppAssets.loader,
                      width: 30,
                      height: 30,
                    ),
                  ),
                );
              },
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
}

