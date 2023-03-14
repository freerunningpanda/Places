import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/details_screen/details_screen_bloc.dart';
import 'package:places/blocs/favorite/favorite_bloc.dart';
import 'package:places/blocs/want_to_visit/want_to_visit_bloc.dart';
import 'package:places/data/dio_configurator.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/place_details/place_details.dart';
import 'package:places/ui/screens/res/custom_colors.dart';
import 'package:places/ui/widgets/cupertino_time_widget.dart';
import 'package:places/ui/widgets/place_icons.dart';

class PlaceCard extends StatelessWidget {
  final String? url;
  final String type;
  final String name;
  final List<Widget> details;
  final Widget actionOne;
  final Widget? actionTwo;
  final double aspectRatio;
  final List<Place> placeList;
  final int placeIndex;
  final bool isVisitingScreen;
  final VoidCallback? removePlace;

  const PlaceCard({
    Key? key,
    required this.url,
    required this.type,
    required this.name,
    required this.details,
    required this.actionOne,
    this.actionTwo,
    required this.aspectRatio,
    required this.placeList,
    required this.placeIndex,
    required this.isVisitingScreen,
    this.removePlace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation == Orientation.portrait;

    return SizedBox(
      height: orientation ? size.height / 2.5 : size.height / 2.0,
      width: size.width,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: customColors.color,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PlaceCardTop(
                    type: type,
                    url: url,
                  ),
                  const SizedBox(height: 16),
                  _PlaceCardBottom(
                    name: name,
                    details: details,
                  ),
                ],
              ),
              RippleCardFull(place: placeList[placeIndex]),
              if (isVisitingScreen)
                RippleIcons(
                  removePlace: removePlace,
                  actionOne: actionOne,
                  actionTwo: actionTwo ?? const SizedBox(),
                )
              else
                RippleIcon(
                  actionOne: actionOne,
                  addPlace: () {
                    final place = placeList[placeIndex];
                    // Если место не в избранном
                    if (!place.isFavorite) {
                      // Добавляю место в избранное, меняя флаг isFavorite на true
                      // Событие добавляет место в список избранного
                      // Отвечает за обновление состояние лайка
                      context.read<FavoriteBloc>().add(
                            FavoriteEvent(
                              isFavorite: place.isFavorite = true,
                              place: place,
                              placeIndex: place.id, // Для того чтобы связать места по его id с бэка
                              // Это позволит при перемешивании позиции места в списке удалять нужное место
                            ),
                          );
                      // Отвечает за отображение списка мест в избранном
                      context.read<WantToVisitBloc>().add(
                            AddToWantToVisitEvent(
                              isFavorite: place.isFavorite = true,
                              place: place,
                              placeIndex: place.id,
                            ),
                          );
                      debugPrint('isFavorite ${place.isFavorite}');
                      debugPrint('Добавлены в избранное: $place');
                    } else {
                      // Если место в избранном, меняю флаг isFavorite на false.
                      // Событие удаляет место из списка избранного
                      context.read<FavoriteBloc>().add(
                            FavoriteEvent(
                              isFavorite: place.isFavorite = false,
                              place: place,
                              placeIndex: place.id,
                            ),
                          );
                      context.read<WantToVisitBloc>().add(
                            RemoveFromWantToVisitEvent(
                              isFavorite: place.isFavorite = false,
                              place: place,
                              placeIndex: place.id,
                            ),
                          );
                      debugPrint('isFavorite ${place.isFavorite}');
                      debugPrint('Удалено из избранного: $place');
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class RippleIcon extends StatelessWidget {
  final Widget actionOne;
  final VoidCallback? addPlace;

  const RippleIcon({
    Key? key,
    required this.actionOne,
    required this.addPlace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      right: 16,
      child: Material(
        type: MaterialType.transparency,
        child: SizedBox(
          width: 22,
          height: 22,
          child: InkWell(
            borderRadius: BorderRadius.circular(16.0),
            onTap: addPlace,
            child: actionOne,
          ),
        ),
      ),
    );
  }
}

class RippleIcons extends StatelessWidget {
  final Widget actionOne;
  final Widget actionTwo;
  final VoidCallback? removePlace;

  const RippleIcons({
    Key? key,
    required this.actionOne,
    required this.actionTwo,
    required this.removePlace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 16,
          right: 55,
          child: Material(
            type: MaterialType.transparency,
            child: SizedBox(
              width: 22,
              height: 22,
              child: InkWell(
                borderRadius: BorderRadius.circular(16.0),
                onTap: () async {
                  if (Platform.isAndroid) {
                    await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                  } else if (Platform.isIOS) {
                    await showModalBottomSheet<CupertinoTimerPicker>(
                      context: context,
                      builder: (_) {
                        return const CupertinoTimeWidget();
                      },
                    );
                  }

                  debugPrint('🟡---------first icon pressed');
                },
                child: actionOne,
              ),
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Material(
            type: MaterialType.transparency,
            child: SizedBox(
              width: 22,
              height: 22,
              child: InkWell(
                borderRadius: BorderRadius.circular(16.0),
                onTap: removePlace,
                child: actionTwo,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RippleCardFull extends StatelessWidget {
  final Place place;

  const RippleCardFull({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            debugPrint('🟡---------to details screen');
            context.read<DetailsScreenBloc>().add(DetailsScreenEvent(place: place));
            Navigator.of(context).push(
              MaterialPageRoute<PlaceDetails>(
                builder: (_) => PlaceDetails(
                  height: 360,
                  place: place,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PlaceCardTop extends StatefulWidget {
  final String type;
  final String? url;

  const _PlaceCardTop({
    Key? key,
    required this.type,
    required this.url,
  }) : super(key: key);

  @override
  State<_PlaceCardTop> createState() => _PlaceCardTopState();
}

class _PlaceCardTopState extends State<_PlaceCardTop> with TickerProviderStateMixin {
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
    return Container(
      height: 96,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            widget.url ?? 'no_url',
            fit: BoxFit.fitWidth,
            loadingBuilder: (_, child, loadingProgress) {
              if (loadingProgress == null) return child;

              return AnimatedBuilder(
                animation: _animationController,
                builder: (_, child) {
                  return Transform.rotate(
                    angle: _rotateAnimation.value,
                    child: const PlaceIcons(
                      assetName: AppAssets.loader,
                      width: 30,
                      height: 30,
                    ),
                  );
                },
              );
            },
            errorBuilder: (_, error, stackTrace) => Image.asset(AppAssets.placeholder),
          ),
          Positioned(
            left: 16,
            top: 16,
            child: Text(
              widget.type,
              style: AppTypography.placeCardTitle,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _PlaceCardBottom extends StatelessWidget {
  final String name;
  final List<Widget> details;
  const _PlaceCardBottom({Key? key, required this.name, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: details,
      ),
    );
  }
}
