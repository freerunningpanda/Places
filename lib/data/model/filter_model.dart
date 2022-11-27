import 'package:flutter/material.dart';

class FilterModel {
  final List<String> category;
  final RangeValues values;

  FilterModel({
    required this.category,
    required this.values,
  });
}
