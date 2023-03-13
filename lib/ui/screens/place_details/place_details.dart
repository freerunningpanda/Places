import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/details_screen/details_screen_bloc.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/widgets/close_bottom_sheet.dart';
import 'package:places/ui/widgets/error_widget.dart';
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
    return Scaffold(
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
            return Column(
              children: [
                Expanded(
                  child: ColoredBox(
                    child: Container(),
                    color: AppColors.detailsScreenBackground,
                  ),
                ),
                const SizedBox(height: 12),
                _PlaceDetailsClosed(
                  height: widget.height,
                  place: widget.place,
                  pageController: _pageController,
                ),
              ],
            );
          }

          return const Center(
            child: ErrorWidget(),
          );
        },
      ),
    );
  }
}

class _PlaceDetailsFull extends StatelessWidget {
  final Place place;
  final double height;
  final PageController _pageController;

  const _PlaceDetailsFull({
    Key? key,
    required this.place,
    required this.height,
    required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final orientation = MediaQuery.of(context).orientation == Orientation.portrait;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            height: 16,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              color: AppColors.detailsScreenBottomSheet,
            ),
          ),
        ),
        Stack(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
                color: theme.scaffoldBackgroundColor,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: orientation ? 629 : 350,
                ),
                child: ListView(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _PlaceDetailsGallery(
                        images: place.urls,
                        height: height,
                        pageController: _pageController,
                      ),
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
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PlaceDetailsClosed extends StatefulWidget {
  final Place place;
  final double height;
  final PageController _pageController;

  const _PlaceDetailsClosed({
    Key? key,
    required this.place,
    required this.height,
    required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  @override
  State<_PlaceDetailsClosed> createState() => _PlaceDetailsClosedState();
}

class _PlaceDetailsClosedState extends State<_PlaceDetailsClosed> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation == Orientation.portrait;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            // clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: _showGallery,
                child: Container(
                  width: 60,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    color: theme.iconTheme.color,
                  ),
                ),
              ),
              SizedBox(
                height: orientation ? size.height / 2.0 : size.height / 1.5,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 8),
                    _DetailsScreenTitle(
                      place: widget.place,
                    ),
                    const SizedBox(height: 24),
                    _DetailsScreenDescription(place: widget.place),
                    const SizedBox(height: 24),
                    _PlaceDetailsBuildRouteBtn(place: widget.place),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),
                    _PlaceDetailsBottom(place: widget.place),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showGallery() {
    showModalBottomSheet<_PlaceDetailsFull>(
      context: context,
      builder: (_) => _PlaceDetailsFull(
        height: widget.height,
        place: widget.place,
        pageController: widget._pageController,
      ),
      isScrollControlled: true,
    );
  }
}

class _PlaceDetailsGallery extends StatefulWidget {
  final List<String> images;
  final double height;
  final PageController _pageController;

  const _PlaceDetailsGallery({
    Key? key,
    required this.images,
    required this.height,
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
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.8,
      child: CustomScrollView(
        // controller: scrollController,
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: widget.height,
            flexibleSpace: Stack(
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
                              ),
                            ),
                          )
                          .values
                          .toList(),
                    ),
                  ),
                ),
                const Positioned(
                  top: 32,
                  right: 16,
                  child: CloseBottomSheet(
                    width: 32,
                    height: 32,
                  ),
                ),
                Positioned(
                  top: 12,
                  left: size.width / 2.3,
                  right: size.width / 2.3,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 40,
                      height: 3,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        color: theme.sliderTheme.thumbColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsScreenTitle extends StatelessWidget {
  final Place place;

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
              '${AppString.closed} 9:00',
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
    return SizedBox(
      height: widget.height,
      child: CachedNetworkImage(
        imageUrl: widget.image,
        fit: BoxFit.cover,
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
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _DetailsScreenDescription extends StatelessWidget {
  final Place place;
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
  final Place place;
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
                AppString.goButtonTitle.toUpperCase(),
                style: AppTypography.placeDetailsButtonName,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceDetailsBottom extends StatelessWidget {
  final Place place;
  const _PlaceDetailsBottom({
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                AppString.schedule,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () => PlaceInteractor(
            repository: PlaceRepository(
              apiPlaces: ApiPlaces(),
            ),
          ).addToFavorites(place: place),
          child: Row(
            children: [
              PlaceIcons(
                assetName: AppAssets.favouriteDark,
                width: 20,
                height: 18,
                color: theme.iconTheme.color,
              ),
              const SizedBox(width: 9),
              Text(
                AppString.favourite,
                style: theme.textTheme.displaySmall,
              ),
              const SizedBox(
                width: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
