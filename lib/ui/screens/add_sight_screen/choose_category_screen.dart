import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/add_sight_screen/choose_category/choose_category_bloc.dart';

import 'package:places/data/model/category.dart';
import 'package:places/providers/category_data_provider.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/widgets/new_place_app_bar_widget.dart';
import 'package:places/ui/widgets/save_button.dart';
import 'package:places/ui/widgets/sight_icons.dart';

class ChooseCategoryWidget extends StatefulWidget {
  const ChooseCategoryWidget({Key? key}) : super(key: key);

  @override
  State<ChooseCategoryWidget> createState() => _ChooseCategoryWidgetState();
}

class _ChooseCategoryWidgetState extends State<ChooseCategoryWidget> {
  final categories = CategoryDataProvider.categories;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 18, right: 16.0, bottom: 8.0),
          child: BlocBuilder<ChooseCategoryBloc, ChooseCategoryState>(
            builder: (_, state) {
              return Column(
                children: [
                  NewPlaceAppBarWidget(
                    theme: theme,
                    width: width / 3.5,
                    leading: const _BackButtonWidget(),
                    title: AppString.category,
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.separated(
                        physics: Platform.isAndroid ? const ClampingScrollPhysics() : const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final category = categories[index];

                          return _ItemCategory(
                            name: category.title,
                            theme: theme,
                            isEnabled: category == state.selectedCategory,
                            category: category,
                            onSelect: (activeCategory) {
                              context.read<ChooseCategoryBloc>().add(
                                    CategoryEvent(category: activeCategory),
                                  );
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: categories.length,
                      ),
                    ),
                  ),
                  const Divider(),
                  SizedBox(height: height * 0.3),
                  SaveButton(
                    chosenCategory: state.selectedCategory,
                    title: AppString.save,
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              );
            },
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
    final chosenCategory = CategoryDataProvider.chosenCategory;

    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () {
        context.read<CategoryDataProvider>().clearCategory(activeCategories: chosenCategory);
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
  final Function(Category) onSelect;

  const _ItemCategory({
    Key? key,
    required this.name,
    required this.theme,
    required this.isEnabled,
    required this.category,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !isEnabled ? () => onSelect(category) : null,
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
