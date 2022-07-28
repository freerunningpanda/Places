import 'package:flutter/material.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/widgets/sight_card_heart_icon.dart';

class SightCardTop extends StatelessWidget {
  final String type;
  final String url;

  const SightCardTop({
    Key? key,
    required this.type,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: NetworkImage(url),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 16,
            top: 16,
            child: Text(
              type,
              style: AppTypography.sightCardTitle,
            ),
          ),
          const Positioned(
            top: 16,
            right: 16,
            child: SightCardHeartIcon(),
          ),
        ],
      ),
    );
  }
}
