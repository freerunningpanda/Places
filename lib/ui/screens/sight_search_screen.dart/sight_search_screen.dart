import 'dart:io';

import 'package:flutter/material.dart';

import 'package:places/appsettings.dart';
import 'package:places/domain/place_ui.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/sight_details/sight_details.dart';
import 'package:places/ui/widgets/search_appbar.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:places/ui/widgets/sight_icons.dart';
import 'package:provider/provider.dart';

class SightSearchScreen extends StatelessWidget {
  const SightSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sightList = context.read<AppSettings>().suggestions;
    const readOnly = false;
    const isSearchPage = true;
    final showHistoryList = context.read<AppSettings>().hasFocus;
    final searchStoryList = context.read<AppSettings>().searchHistoryList;
    final width = MediaQuery.of(context).size.width;

    context.watch<AppSettings>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const SearchAppBar(),
              const SizedBox(height: 16),
              const SearchBar(
                isSearchPage: isSearchPage,
                readOnly: readOnly,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (showHistoryList && searchStoryList.isNotEmpty)
                        _SearchHistoryList(
                          theme: theme,
                          searchStoryList: searchStoryList,
                          width: width,
                        )
                      else
                        const SizedBox(),
                      _SightListWidget(sightList: sightList, theme: theme),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SightListWidget extends StatelessWidget {
  final List<PlaceUI> sightList;
  final ThemeData theme;
  const _SightListWidget({Key? key, required this.sightList, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final suggestions = context.read<AppSettings>().suggestions;

    return suggestions.isEmpty
        ? _EmptyListWidget(
            height: height,
            width: width,
            theme: theme,
          )
        : ListView.builder(
            physics: Platform.isAndroid ? const ClampingScrollPhysics() : const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: sightList.length,
            itemBuilder: (context, index) {
              final sight = sightList[index];

              return _SightCardWidget(
                sight: sight,
                width: width,
                theme: theme,
              );
            },
          );
  }
}

class _EmptyListWidget extends StatelessWidget {
  final double height;
  final double width;
  final ThemeData theme;

  const _EmptyListWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _EmptyStateWidget(height: height, width: width);
  }
}

class _SearchHistoryList extends StatelessWidget {
  final Set<String> searchStoryList;
  final ThemeData theme;
  final double width;

  const _SearchHistoryList({
    Key? key,
    required this.searchStoryList,
    required this.theme,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: Platform.isAndroid ? const ClampingScrollPhysics() : const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        _SearchHistoryTitle(theme: theme),
        const SizedBox(height: 4),
        _SearchItem(
          theme: theme,
          searchStoryList: searchStoryList,
          width: width,
        ),
        const SizedBox(height: 15),
        const _ClearHistoryButton(),
      ],
    );
  }
}

class _ClearHistoryButton extends StatelessWidget {
  const _ClearHistoryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.read<AppSettings>().removeAllItemsFromHistory(),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          AppString.clearHistory,
          style: AppTypography.clearButton,
        ),
      ),
    );
  }
}

class _SearchHistoryTitle extends StatelessWidget {
  final ThemeData theme;

  const _SearchHistoryTitle({
    Key? key,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppString.youSearch,
      style: theme.textTheme.labelLarge,
    );
  }
}

class _SearchItem extends StatelessWidget {
  final ThemeData theme;
  final Set<String> searchStoryList;
  final double width;

  const _SearchItem({
    Key? key,
    required this.theme,
    required this.searchStoryList,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<AppSettings>();

    return Column(
      children: searchStoryList
          .map(
            (e) => Column(
              children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => context.read<AppSettings>().searchController.text = e,
                      child: SizedBox(
                        width: width * 0.7,
                        child: Text(
                          e,
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        context.read<AppSettings>().removeItemFromHistory(e);
                      },
                      child: const SightIcons(assetName: AppAssets.delete, width: 24, height: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
              ],
            ),
          )
          .toList(),
    );
  }
}

class _EmptyStateWidget extends StatelessWidget {
  final double height;
  final double width;

  const _EmptyStateWidget({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: height * 0.2,
          ),
          const SightIcons(
            assetName: AppAssets.search,
            width: 64,
            height: 64,
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            AppString.noPlaces,
            style: AppTypography.emptyListTitle,
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: width * 0.6,
            child: const Text(
              AppString.tryToChange,
              style: AppTypography.detailsTextDarkMode,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: height * 0.2,
          ),
        ],
      ),
    );
  }
}

class _SightCardWidget extends StatelessWidget {
  final PlaceUI sight;
  final double width;
  final ThemeData theme;

  const _SightCardWidget({
    Key? key,
    required this.sight,
    required this.width,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: SizedBox(
            child: Row(
              children: [
                _SightImage(sight: sight),
                const SizedBox(width: 16),
                _SightContent(width: width, sight: sight, theme: theme),
              ],
            ),
          ),
        ),
        _RippleEffect(sight: sight),
      ],
    );
  }
}

class _RippleEffect extends StatelessWidget {
  final PlaceUI sight;

  const _RippleEffect({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => Navigator.of(context).push<SightDetails>(
            MaterialPageRoute(
              builder: (context) => SightDetails(
                place: sight,
                height: 360,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SightContent extends StatelessWidget {
  final double width;
  final PlaceUI sight;
  final ThemeData theme;

  const _SightContent({
    Key? key,
    required this.width,
    required this.sight,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _SightTitle(width: width, sight: sight, theme: theme),
        const SizedBox(height: 8),
        _SightType(sight: sight, theme: theme),
        const SizedBox(height: 16),
        Container(
          height: 1,
          width: width * 0.73,
          color: theme.dividerColor,
        ),
      ],
    );
  }
}

class _SightType extends StatelessWidget {
  final PlaceUI sight;
  final ThemeData theme;

  const _SightType({
    Key? key,
    required this.sight,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      sight.placeType,
      style: theme.textTheme.bodyMedium,
    );
  }
}

class _SightTitle extends StatelessWidget {
  final double width;
  final PlaceUI sight;
  final ThemeData theme;

  const _SightTitle({
    Key? key,
    required this.width,
    required this.sight,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.73,
      child: Text(
        sight.name,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyLarge,
      ),
    );
  }
}

class _SightImage extends StatelessWidget {
  final PlaceUI sight;

  const _SightImage({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(sight.urls[0]),
            // NetworkImage(
            //   sight.url ?? 'null',
            // ),
          ),
        ),
      ),
    );
  }
}
