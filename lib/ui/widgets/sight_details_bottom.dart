import 'package:flutter/material.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/widgets/calendar_icon.dart';
import 'package:places/ui/widgets/sight_card_dark_heart_icon.dart';

class SightDetailsBottom extends StatelessWidget {
  const SightDetailsBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {},
          child: Row(
            children: const [
              SizedBox(
                width: 17,
              ),
              CalendarIcon(),
              SizedBox(width: 9),
              Text(
                AppString.schedule,
                style: AppTypography.inactiveButtonColor,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Row(
            children: const [
              SightCardDarkHeartIcon(),
              SizedBox(width: 9),
              Text(
                AppString.favourite,
                style: AppTypography.activeButtonColor,
              ),
              SizedBox(
                width: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
