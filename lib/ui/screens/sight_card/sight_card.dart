import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/favorite/favorite_bloc.dart';
import 'package:places/blocs/visiting_screen/visiting_screen_bloc.dart';
import 'package:places/data/model/place.dart';

import 'package:places/ui/res/app_card_size.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/res/custom_colors.dart';
import 'package:places/ui/screens/sight_details/sight_details.dart';
import 'package:places/ui/widgets/cupertino_time_widget.dart';

class SightCard extends StatelessWidget {
  final String? url;
  final String type;
  final String name;
  final List<Widget> details;
  final Widget actionOne;
  final Widget? actionTwo;
  final double? aspectRatio;
  final List<Place> placeList;
  final int placeIndex;
  final bool isVisitingScreen;
  final VoidCallback? removeSight;

  const SightCard({
    Key? key,
    required this.url,
    required this.type,
    required this.name,
    required this.details,
    required this.actionOne,
    this.actionTwo,
    this.aspectRatio,
    required this.placeList,
    required this.placeIndex,
    required this.isVisitingScreen,
    this.removeSight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation == Orientation.portrait;

    return SizedBox(
      height: orientation ? size.height / 2.5 : size.height / 2.0,
      width: size.width,
      child: AspectRatio(
        aspectRatio: aspectRatio ?? AppCardSize.sightCard,
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
                    _SightCardTop(
                      type: type,
                      url: url,
                    ),
                    const SizedBox(height: 16),
                    _SightCardBottom(
                      name: name,
                      details: details,
                    ),
                  ],
                ),
                RippleCardFull(place: placeList[placeIndex]),
                if (isVisitingScreen)
                  RippleIcons(
                    removeSight: removeSight,
                    actionOne: actionOne,
                    actionTwo: actionTwo ?? const SizedBox(),
                  )
                else
                  RippleIcon(
                    actionOne: actionOne,
                    addSight: () {
                      final place = placeList[placeIndex];
                      // Если место не в избранном
                      if (!place.isFavorite) {
                        // Добавляю место в избранное, меняя флаг isFavorite на true
                        // Событие добавляет место в список избранного
                        context.read<FavoriteBloc>().add(
                              FavoriteEvent(
                                isFavorite: place.isFavorite = true,
                                place: place,
                                placeIndex: place.id, // Для того чтобы связать места по его id с бэка
                                // Это позволит при перемешивании позиции места в списке удалять нужное место
                              ),
                            );
                        context.read<VisitingScreenBloc>().add(
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
                        context.read<VisitingScreenBloc>().add(
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
      ),
    );
  }
}

class RippleIcon extends StatelessWidget {
  final Widget actionOne;
  final VoidCallback? addSight;

  const RippleIcon({
    Key? key,
    required this.actionOne,
    required this.addSight,
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
            onTap: addSight,
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
  final VoidCallback? removeSight;

  const RippleIcons({
    Key? key,
    required this.actionOne,
    required this.actionTwo,
    required this.removeSight,
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
                onTap: removeSight,
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
            Navigator.of(context).push(
              MaterialPageRoute<SightDetails>(
                builder: (context) => SightDetails(
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

class _SightCardTop extends StatelessWidget {
  // final Widget actionOne;
  final String type;
  final String? url;

  const _SightCardTop({
    Key? key,
    // required this.actionOne,
    required this.type,
    required this.url,
  }) : super(key: key);

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
            url ?? 'no_url',
            fit: BoxFit.fitWidth,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
          ),
          Positioned(
            left: 16,
            top: 16,
            child: Text(
              type,
              style: AppTypography.sightCardTitle,
            ),
          ),
        ],
      ),
    );
  }
}

class _SightCardBottom extends StatelessWidget {
  final String name;
  final List<Widget> details;
  const _SightCardBottom({Key? key, required this.name, required this.details}) : super(key: key);

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
