import 'package:flutter/material.dart';
import 'package:places/appsettings.dart';
import 'package:places/data/categories_table.dart';
import 'package:places/data/filters.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/widgets/action_button.dart';
import 'package:places/ui/widgets/new_place_app_bar_widget.dart';
import 'package:places/ui/widgets/sight_icons.dart';
import 'package:provider/provider.dart';

class ChooseCategoryWidget extends StatefulWidget {
  const ChooseCategoryWidget({Key? key}) : super(key: key);

  @override
  State<ChooseCategoryWidget> createState() => _ChooseCategoryWidgetState();
}

class _ChooseCategoryWidgetState extends State<ChooseCategoryWidget> {
  final categories = CategoriesTable.categories;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    context.watch<AppSettings>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 18, right: 16.0, bottom: 8.0),
            child: Column(
              children: [
                NewPlaceAppBarWidget(
                  theme: theme,
                  width: width / 3.5,
                  leading: const _BackButtonWidget(),
                  title: AppString.category,
                ),
                const SizedBox(height: 40),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final category = categories[index];

                    return _ItemCategory(
                      name: category.title,
                      theme: theme,
                      isEnabled: category.isEnabled,
                      category: category,
                      onTap: () {
                        context.read<AppSettings>().chooseCategory(
                              index: index,
                              categories: CategoriesTable.categories,
                              activeCategories: CategoriesTable.chosenCategory,
                            );
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: categories.length,
                ),
                const Divider(),
                SizedBox(height: height * 0.3),
                ActionButton(
                  title: AppString.save,
                  onTap: () {
                    if (CategoriesTable.chosenCategory.isEmpty) {
                      return;
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BackButtonWidget extends StatelessWidget {
  const _BackButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chosenCategory = CategoriesTable.chosenCategory;

    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () {
        context.read<AppSettings>().clearCategory(activeCategories: chosenCategory);
        Navigator.pop(context);
      },
      child: const Icon(Icons.chevron_left),
    );
  }
}

class _ItemCategory extends StatelessWidget {
  final String name;
  final ThemeData theme;
  final bool isEnabled;
  final Category category;
  final VoidCallback onTap;

  const _ItemCategory({
    Key? key,
    required this.name,
    required this.theme,
    required this.isEnabled,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 38,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: theme.textTheme.bodyLarge,
            ),
            if (isEnabled) const SightIcons(assetName: AppAssets.tick, width: 24, height: 24) else const SizedBox(),
          ],
        ),
      ),
    );
  }
}
