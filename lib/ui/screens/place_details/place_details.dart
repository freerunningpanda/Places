import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/details_screen/details_screen_bloc.dart';
import 'package:places/blocs/want_to_visit/want_to_visit_bloc.dart';
import 'package:places/data/database/database.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/navigation_screen/navigation_screen.dart';
import 'package:places/ui/widgets/chevrone_back.dart';
import 'package:places/ui/widgets/error_widget.dart';
import 'package:places/ui/widgets/place_icons.dart';

class PlaceDetails extends StatefulWidget {
  final DbPlace place;
  final double height;
  final bool fromMainScreen;
  const PlaceDetails({
    Key? key,
    required this.place,
    required this.height,
    required this.fromMainScreen,
  }) : super(key: key);

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> with TickerProviderStateMixin {
  final _pageController = PageController();
  late final AnimationController _animationController;
  late final Animation<double> _rotateAnimation;

  @override
  void initState() {
    var currentIndex = 0;
    Timer.periodic(
      const Duration(
        seconds: 3,
      ),
      (timer) {
        currentIndex++;
        if (currentIndex > widget.place.urls.length) {
          currentIndex = 0;
        }
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            currentIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        }
      },
    );
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
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (widget.fromMainScreen) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<NavigationScreen>(
              builder: (_) => const NavigationScreen(),
            ),
          );
        } else {
          Navigator.pop(context);
        }

        return Future.value(false);
      },
      child: Scaffold(
        body: BlocBuilder<DetailsScreenBloc, DetailsScreenState>(
          builder: (_, state) {
            if (state is DetailsScreenLoadingState) {
              return Transform.rotate(
                angle: _rotateAnimation.value,
                child: const PlaceIcons(
                  assetName: AppAssets.loader,
                  width: 30,
                  height: 30,
                ),
              );
            } else if (state is DetailsScreenLoadedState) {
              return _PlaceDetails(
                height: widget.height,
                place: widget.place,
                pageController: _pageController,
                fromMainScreen: widget.fromMainScreen,
              );
            }

            return const Center(
              child: ErrorWidget(),
            );
          },
        ),
      ),
    );
  }
}

class _PlaceDetails extends StatelessWidget {
  final DbPlace place;
  final double height;
  final bool fromMainScreen;
  final PageController _pageController;

  const _PlaceDetails({
    Key? key,
    required this.place,
    required this.height,
    required this.fromMainScreen,
    required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Получить список картинок из строки
    final urlsList = place.urls.split('|');

    return SingleChildScrollView(
      child: Column(
        children: [
          _PlaceDetailsGallery(
            place: place,
            images: urlsList,
            height: height,
            pageController: _pageController,
            fromMainScreen: fromMainScreen,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                _DetailsScreenTitle(
                  place: place,
                ),
                const SizedBox(height: 24),
                _DetailsScreenDescription(place: place),
                const SizedBox(height: 24),
                _PlaceDetailsBuildRouteBtn(place: place),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                _PlaceDetailsBottom(place: place),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceDetailsGallery extends StatefulWidget {
  final List<String> images;
  final double height;
  final DbPlace place;
  final bool fromMainScreen;
  final PageController _pageController;

  const _PlaceDetailsGallery({
    Key? key,
    required this.images,
    required this.height,
    required this.place,
    required this.fromMainScreen,
    required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  @override
  State<_PlaceDetailsGallery> createState() => _PlaceDetailsGalleryState();
}

class _PlaceDetailsGalleryState extends State<_PlaceDetailsGallery> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.8,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: widget.height,
            child: Scrollbar(
              controller: widget._pageController,
              child: PageView(
                controller: widget._pageController,
                children: widget.images
                    .asMap()
                    .map(
                      (i, e) => MapEntry(
                        i,
                        _PlaceDetailsImage(
                          height: widget.height,
                          image: e,
                          place: widget.place,
                        ),
                      ),
                    )
                    .values
                    .toList(),
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 36,
            child: ChevroneBack(
              width: 32,
              height: 32,
              fromMainScreen: widget.fromMainScreen,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsScreenTitle extends StatelessWidget {
  final DbPlace place;

  const _DetailsScreenTitle({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          place.name,
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 2,
        ),
        Row(
          children: [
            Text(
              place.placeType,
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(width: 16),
            Text(
              '${AppStrings.closed} 9:00',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}

class _PlaceDetailsImage extends StatefulWidget {
  final String image;
  final double height;
  final DbPlace place;
  const _PlaceDetailsImage({
    Key? key,
    required this.image,
    required this.height,
    required this.place,
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
    return SizedBox(
      height: widget.height,
      child: Hero(
        tag: widget.place.name,
        child: CachedNetworkImage(
          imageUrl: widget.image,
          fit: BoxFit.cover,
          // ignore: avoid_annotating_with_dynamic
          errorWidget: (context, url, dynamic error) => Image.asset(AppAssets.placeholder),
          progressIndicatorBuilder: (_, url, progress) => AnimatedBuilder(
            animation: _animationController,
            builder: (_, child) {
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
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _DetailsScreenDescription extends StatelessWidget {
  final DbPlace place;
  const _DetailsScreenDescription({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      child: Text(
        place.description,
        style: theme.textTheme.displaySmall,
      ),
    );
  }
}

class _PlaceDetailsBuildRouteBtn extends StatelessWidget {
  final DbPlace place;
  const _PlaceDetailsBuildRouteBtn({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: theme.sliderTheme.activeTrackColor,
        ),
        child: GestureDetector(
          onTap: () => debugPrint('🟡---------Build a route pressed'),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PlaceIcons(
                assetName: AppAssets.goIcon,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              Text(
                AppStrings.goButtonTitle.toUpperCase(),
                style: AppTypography.placeDetailsButtonName,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceDetailsBottom extends StatefulWidget {
  final DbPlace place;
  const _PlaceDetailsBottom({
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  State<_PlaceDetailsBottom> createState() => _PlaceDetailsBottomState();
}

class _PlaceDetailsBottomState extends State<_PlaceDetailsBottom> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final db = context.read<AppDb>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => debugPrint('🟡---------Schedule pressed'),
          child: Row(
            children: const [
              SizedBox(
                width: 17,
              ),
              PlaceIcons(
                assetName: AppAssets.calendar,
                width: 22,
                height: 19,
              ),
              SizedBox(width: 9),
              Text(
                AppStrings.schedule,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () => toggleFavorite(widget.place),
          child: FutureBuilder(
            future: getValue(db, widget.place),
            // ignore: avoid_types_on_closure_parameters
            builder: (_, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final isFavorite = snapshot.data ?? false;

                return Row(
                  children: [
                    if (isFavorite)
                      const PlaceIcons(
                        assetName: AppAssets.heartFull,
                        width: 20,
                        height: 18,
                      )
                    else
                      const PlaceIcons(
                        assetName: AppAssets.favourite,
                        width: 20,
                        height: 18,
                      ),
                    const SizedBox(width: 9),
                    Text(
                      AppStrings.favourite,
                      style: theme.textTheme.displaySmall,
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                  ],
                );
              } else {
                return Row(
                  children: [
                    const PlaceIcons(
                      assetName: AppAssets.favourite,
                      width: 20,
                      height: 18,
                    ),
                    const SizedBox(width: 9),
                    Text(
                      AppStrings.favourite,
                      style: theme.textTheme.displaySmall,
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Future<void> toggleFavorite(DbPlace place) async {
    final db = context.read<AppDb>();
    final isFavorite = await getValue(db, place);
    setState(() {
      if (!isFavorite) {
        place.isFavorite = true;
        context.read<WantToVisitBloc>().add(
              AddToWantToVisitEvent(
                db: db,
                isFavorite: place.isFavorite,
                place: place,
              ),
            );
        db.addPlace(place, isSearchScreen: false);
      } else {
        place.isFavorite = false;
        context.read<WantToVisitBloc>().add(
              RemoveFromWantToVisitEvent(
                db: db,
                isFavorite: place.isFavorite,
                place: place,
              ),
            );
        db.deletePlace(place);
      }
    });
  }

  // Получить значение свойства isFavorite
  Future<bool> getValue(AppDb db, DbPlace place) async {
    final list = await db.favoritePlacesEntries;
    final isFavorite = list.any((p) => p.id == place.id);

    return isFavorite;
  }
}
