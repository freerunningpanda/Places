import 'package:flutter/material.dart';

import 'package:places/appsettings.dart';
import 'package:places/data/sight.dart';
import 'package:places/ui/screens/sight_details/sight_details.dart';
import 'package:places/ui/widgets/search_appbar.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class SightSearchScreen extends StatelessWidget {
  const SightSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sightList = context.read<AppSettings>().suggestions;
    const readOnly = false;
    const isSearchPage = true;
    context.watch<AppSettings>();

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            const SizedBox(height: 16),
            const SearchAppBar(),
            SearchBar(
              isSearchPage: isSearchPage,
              sightList: sightList,
              readOnly: readOnly,
            ),
            _SightListWidget(sightList: sightList),
          ],
        ),
      ),
    );
  }
}

class _SightListWidget extends StatelessWidget {
  final List<Sight> sightList;
  const _SightListWidget({Key? key, required this.sightList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: sightList.length,
        itemBuilder: (context, index) {
          final sight = sightList[index];

          return Stack(
            children: [
              Row(
                children: [
                  Image.network(
                    sight.url ?? 'null',
                    width: 156,
                    height: 156,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          sight.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(sight.type),
                    ],
                  ),
                ],
              ),
              Positioned.fill(
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () => Navigator.of(context).push<SightDetails>(
                      MaterialPageRoute(
                        builder: (context) => SightDetails(sight: sight),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
