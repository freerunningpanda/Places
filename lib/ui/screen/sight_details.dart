import 'package:flutter/material.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/widgets/calendar_icon.dart';
import 'package:places/ui/widgets/sight_card_favourite_heart_icon.dart';
import 'package:places/ui/widgets/sight_details_button_icon.dart';

class SightDetails extends StatelessWidget {
  const SightDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: w,
          height: h,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: w,
                  height: h * 0.45,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    image: const DecorationImage(
                      image: AssetImage('lib/res/images/no_image.png'),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 36,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.chevron_left,
                    color: Color.fromRGBO(37, 40, 73, 1),
                    size: 25,
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: h * 0.5,
                child: const Text(
                  'Пряности и радости',
                  style: AppTypography.sightDetailsTitle,
                ),
              ),
              Positioned(
                left: 16,
                top: h * 0.55,
                child: Row(
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
              ),
              Positioned(
                left: 16,
                top: h * 0.62,
                child: const SizedBox(
                  width: 328,
                  child: Text(
                    'Пряный вкус радостной жизни вместе с шеф-поваром Изо Дзандзава, благодаря которой у гостей ресторана есть возможность выбирать из двух направлений: европейского и восточного',
                    style: AppTypography.sightDetailsDescription,
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: h * 0.17,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromRGBO(76, 175, 80, 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SightDetailsGoButtonIcon(),
                      const SizedBox(width: 8),
                      Text(
                        'Построить маршрут'.toUpperCase(),
                        style: AppTypography.sightDetailsButtonName,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                bottom: h * 0.13,
                right: 16,
                child: Opacity(
                  opacity: 0.03,
                  child: Container(
                    height: 1,
                    width: w,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                left: 16,
                bottom: h * 0.07,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: const [
                        CalendarIcon(),
                        SizedBox(width: 9),
                        Text(
                          'Запланировать',
                          style: AppTypography.inactiveButtonColor,
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        SightCardFavouriteHeartIcon(),
                        SizedBox(width: 9),
                        Text(
                          'В избранное',
                          style: AppTypography.activeButtonColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
