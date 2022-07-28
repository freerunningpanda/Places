import 'package:flutter/material.dart';
import 'package:places/ui/res/app_typography.dart';

class SightCardBottom extends StatelessWidget {
  final String name;
  final String details;
  const SightCardBottom({Key? key, required this.name, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            maxLines: 2,
            style: AppTypography.sightCardDescriptionTitle,
          ),
          const SizedBox(height: 2),
          Text(
            details,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.textText16Regular,
          ),
        ],
      ),
    );
  }
}
