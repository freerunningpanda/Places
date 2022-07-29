import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

import 'package:places/ui/res/app_typography.dart';

class DetailsScreenDescription extends StatelessWidget {
  final Sight sight;
  const DetailsScreenDescription({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        sight.details,
        style: AppTypography.sightDetailsDescription,
      ),
    );
  }
}
