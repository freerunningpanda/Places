import 'package:flutter/material.dart';
import 'package:places/ui/widgets/sight_card_bottom.dart';
import 'package:places/ui/widgets/sight_card_top.dart';


class SightCard extends StatelessWidget {
  final String url;
  final String type;
  final String name;
  final String details;
  const SightCard({
    Key? key,
    required this.url,
    required this.type,
    required this.name,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        margin: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(245, 245, 245, 1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            SightCardTop(
              type: type,
              url: url,
            ),
            const SizedBox(height: 16),
            SightCardBottom(
              name: name,
              details: details,
            ),
          ],
        ),
      ),
    );
  }
}
