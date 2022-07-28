import 'package:flutter/material.dart';

import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/widgets/details_screen_description.dart';
import 'package:places/ui/widgets/sight_details_bottom.dart';
import 'package:places/ui/widgets/sight_details_build_route_btn.dart';
import 'package:places/ui/widgets/sight_details_chevrone_back.dart';
import 'package:places/ui/widgets/sight_details_image.dart';

class SightDetails extends StatelessWidget {
  const SightDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: const [
                SightDetailsImage(
                  height: 361,
                ),
                Positioned(
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
                  const Text(
                    'Пряности и радости',
                    style: AppTypography.sightDetailsTitle,
                  ),
                  const SizedBox(height: 2,),
                  Row(
                    children: const [
                      Text(
                        'ресторан',
                        style: AppTypography.sightDetailsSubtitle,
                      ),
                      SizedBox(width: 16),
                      Text(
                        'закрыто до 09:00',
                        style: AppTypography.sightDetailsSubtitleWithTime,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const DetailsScreenDescription(),
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
