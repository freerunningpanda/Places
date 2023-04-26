import 'package:flutter/material.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/widgets/search_appbar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: const [
            SizedBox(height: 16),
            SearchAppBar(title: AppStrings.mapScreenTitle),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
