import 'package:flutter/material.dart';

class SightDetailsImage extends StatelessWidget {
  final double height;
  const SightDetailsImage({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        image: const DecorationImage(
          image: AssetImage('lib/ui/res/images/no_image.png'),
        ),
      ),
    );
  }
}
