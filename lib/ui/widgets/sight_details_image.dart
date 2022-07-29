import 'package:flutter/material.dart';

import 'package:places/domain/sight.dart';


class SightDetailsImage extends StatelessWidget {
  final Sight sight;
  final double height;
  const SightDetailsImage({
    Key? key,
    required this.sight,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(sight.url),
        ),
      ),
    );
  }
}
