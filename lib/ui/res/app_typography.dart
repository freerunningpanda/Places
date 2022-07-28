import 'package:flutter/material.dart';

abstract class AppTypography {
  static const textText16Regular = TextStyle(
    fontSize: 16.0,
    height: 1.25,
    fontWeight: FontWeight.w400,
  );

  static const appBarTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: Color.fromARGB(255, 32, 33, 37),
  );

  static const sightCardTitle = TextStyle(
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const sightCardDescriptionTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color.fromRGBO(59, 62, 91, 1),
  );

  static const sideCardDescription = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(124, 126, 146, 1),
  );

  static const sightDetailsTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(59, 62, 91, 1),
  );

  static const sightDetailsSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(59, 62, 91, 1),
  );

  static const sightDetailsSubtitleWithTime = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(124, 126, 146, 1),
  );

  static const sightDetailsDescription = TextStyle(
    fontSize: 14,
    color: Color.fromRGBO(59, 62, 91, 1),
  );

  static const sightDetailsButtonName = TextStyle(
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const inactiveButtonColor = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0.3),
  );

  static const activeButtonColor = TextStyle(
    color: Color.fromRGBO(59, 62, 91, 1),
  );
}
