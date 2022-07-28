import 'package:flutter/material.dart';

import 'package:places/ui/res/app_typography.dart';

class DetailsScreenDescription extends StatelessWidget {
  const DetailsScreenDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Text(
        'Пряный вкус радостной жизни вместе с шеф-поваром Изо Дзандзава, благодаря которой у гостей ресторана есть возможность выбирать из двух направлений: европейского и восточного',
        style: AppTypography.sightDetailsDescription,
      ),
    );
  }
}
