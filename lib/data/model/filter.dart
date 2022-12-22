import 'package:flutter/material.dart';

class Filter {
  final List<String> category;
  final RangeValues values;

  Filter({
    required this.category,
    required this.values,
  });
}
