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
  int? selectedIndex;

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

                          return ListTile(
                            onTap: () {
                              selectedIndex = index;
                              context.read<ChooseCategoryBloc>().add(
                                    AddCategoryEvent(
                                      category: category,
                                      isEnabled: category.isEnabled = true,
                                      index: index,
                                    ),
                                  );
                            },
                            title: Text(
                              category.title,
                              style: theme.textTheme.bodyLarge,
                            ),
                            trailing: selectedIndex == index
                                ? const SightIcons(assetName: AppAssets.tick, width: 24, height: 24)
                                : const SizedBox(),
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
                  SaveButton(
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
  final int index;
  final String name;
  final ThemeData theme;
  final bool isEnabled;
  final List<Category> categoryList;
  final Function(Category) onSelect;

  const _ItemCategory({
    Key? key,
    required this.index,
    required this.name,
    required this.theme,
    required this.isEnabled,
    required this.categoryList,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = categoryList[index];

    return InkWell(
      onTap: () => onSelect(category),
      child: SizedBox(
        height: 38,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: theme.textTheme.bodyLarge,
            ),
            BlocBuilder<ChooseCategoryBloc, ChooseCategoryState>(
              builder: (context, state) {
                if (state is ChosenCategoryState) {
                  return category.isEnabled
                      ? const SightIcons(assetName: AppAssets.tick, width: 24, height: 24)
                      : const SizedBox();
                } else if (state is NotChosenCategoryState) {
                  return category.isEnabled
                      ? const SightIcons(assetName: AppAssets.tick, width: 24, height: 24)
                      : const SizedBox();
                }

                throw ArgumentError('Bad State');
              },
            ),
          ],
        ),
      ),
    );
  }
}
