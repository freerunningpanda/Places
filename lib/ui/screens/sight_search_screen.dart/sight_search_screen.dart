import 'package:flutter/material.dart';
import 'package:places/data/sight.dart';
import 'package:places/ui/widgets/search_appbar.dart';

import 'package:places/ui/widgets/search_bar.dart';

class SightSearchScreen extends StatelessWidget {
  final List<Sight> sightList;
  const SightSearchScreen({Key? key, required this.sightList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 16),
              const SearchAppBar(),
              SearchBar(
                sightList: sightList,
                onTap: () {
                  debugPrint('🟡--------- Search pressed');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
