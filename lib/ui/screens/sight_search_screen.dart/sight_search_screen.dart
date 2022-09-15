import 'package:flutter/material.dart';

import 'package:places/appsettings.dart';
import 'package:places/data/sight.dart';
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
    final sightList = context.read<AppSettings>().suggestions;
    const readOnly = false;
    const isSearchPage = true;

    context.watch<AppSettings>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            const SizedBox(height: 16),
            const SearchAppBar(),
            const SearchBar(
              isSearchPage: isSearchPage,
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
    final height = MediaQuery.of(context).size.height;
    final suggestions = context.read<AppSettings>().suggestions;

    return suggestions.isEmpty
        ? _EmptyListWidget(height: height, width: width)
        : Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
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
            ),
          );
  }
}

class _EmptyListWidget extends StatelessWidget {
  final double height;
  final double width;

  const _EmptyListWidget({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}

class _SightCardWidget extends StatelessWidget {
  final Sight sight;
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 11),
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
  final Sight sight;

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
              builder: (context) => SightDetails(sight: sight),
            ),
          ),
        ),
      ),
    );
  }
}

class _SightContent extends StatelessWidget {
  final double width;
  final Sight sight;
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
  final Sight sight;
  final ThemeData theme;

  const _SightType({
    Key? key,
    required this.sight,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      sight.type,
      style: theme.textTheme.bodyMedium,
    );
  }
}

class _SightTitle extends StatelessWidget {
  final double width;
  final Sight sight;
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
  final Sight sight;

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
            image: NetworkImage(
              sight.url ?? 'null',
            ),
          ),
        ),
      ),
    );
  }
}
