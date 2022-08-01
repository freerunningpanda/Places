import 'package:flutter/material.dart';
import 'package:places/ui/res/app_card_size.dart';

import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_typography.dart';

class SightCard extends StatelessWidget {
  final String url;
  final String type;
  final String name;
  final List<Widget> details;
  final List<Widget> actions;
  final double? aspectRatio;
  const SightCard({
    Key? key,
    required this.url,
    required this.type,
    required this.name,
    required this.details,
    required this.actions,
    this.aspectRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          color: AppColors.sightCardBackground,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
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
          Positioned(
            top: 16,
            right: 16,
            child: Row(
              children: actions,
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
