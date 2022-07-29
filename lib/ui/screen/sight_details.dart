import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/widgets/details_screen_description.dart';
import 'package:places/ui/widgets/sight_details_bottom.dart';
import 'package:places/ui/widgets/sight_details_build_route_btn.dart';
import 'package:places/ui/widgets/sight_details_chevrone_back.dart';
import 'package:places/ui/widgets/sight_details_image.dart';

class SightDetails extends StatelessWidget {
  final Sight sight;
  const SightDetails({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SightDetailsImage(
                  sight: sight,
                  height: 361,
                ),
                const Positioned(
                  left: 16,
                  top: 36,
                  child: SightDetailsChevroneBack(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sight.name,
                    style: AppTypography.sightDetailsTitle,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        sight.type,
                        style: AppTypography.sightDetailsSubtitle,
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'закрыто до 09:00',
                        style: AppTypography.sightDetailsSubtitleWithTime,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  DetailsScreenDescription(sight: sight,),
                  const SizedBox(height: 24),
                  const SightDetailsBuildRouteBtn(),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  const SightDetailsBottom(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
