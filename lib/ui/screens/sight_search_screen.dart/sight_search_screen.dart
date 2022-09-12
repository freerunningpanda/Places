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
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: sightList.length,
        itemBuilder: (context, index) {
          final sight = sightList[index];

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 11),
                child: SizedBox(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                sight.url ?? 'null',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          SizedBox(
                            width: width * 0.73,
                            child: Text(
                              sight.name,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            sight.type,
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 1,
                            width: width * 0.73,
                            color: theme.dividerColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
