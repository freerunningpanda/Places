import 'package:flutter/material.dart';
import 'package:places/data/sight.dart';

import 'package:places/ui/res/app_card_size.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/res/custom_colors.dart';
import 'package:places/ui/screens/sight_details/sight_details.dart';

class SightCard extends StatelessWidget {
  final String url;
  final String type;
  final String name;
  final List<Widget> details;
  final List<Widget> actions;
  final double? aspectRatio;
  final Sight item;

  const SightCard({
    Key? key,
    required this.url,
    required this.type,
    required this.name,
    required this.details,
    required this.actions,
    this.aspectRatio,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return AspectRatio(
      aspectRatio: aspectRatio ?? AppCardSize.sightCard,
      child: Container(
        margin: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: customColors.color,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          child: Stack(
            children: [
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SightCardTop(
                        actions: actions,
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
                ],
              ),
              RippleCardFull(item: item),
              RippleIcons(actions: actions),
            ],
          ),
        ),
      ),
    );
  }
}

class RippleIcons extends StatelessWidget {
  final List<Widget> actions;

  const RippleIcons({
    Key? key,
    required this.actions,
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
            onTap: () {
              debugPrint('like');
            },
            child: Row(
              children: actions,
            ),
          ),
        ),
      ),
    );
  }
}

class RippleCardFull extends StatelessWidget {
  final Sight item;

  const RippleCardFull({
    Key? key,
    required this.item,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            debugPrint('to details');
            Navigator.of(context).push(
              MaterialPageRoute<SightDetails>(
                builder: (context) => SightDetails(
                  sight: item,
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
  final List<Widget> actions;
  final String type;
  final String url;

  const _SightCardTop({
    Key? key,
    required this.actions,
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
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              url,
              fit: BoxFit.fitWidth,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
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
