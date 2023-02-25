import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/choose_category_bloc/choose_category_bloc.dart';

import 'package:places/data/model/category.dart';
import 'package:places/providers/category_data_provider.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/widgets/new_place_app_bar_widget.dart';
import 'package:places/ui/widgets/save_button.dart';
import 'package:places/ui/widgets/sight_icons.dart';
import 'package:provider/provider.dart';

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

    // context.watch<CategoryDataProvider>();

    return Scaffold(
      body: SafeArea(
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
                        isEnabled: category.isEnabled,
                        category: category,
                        onTap: () {
                          context.read<CategoryDataProvider>().chooseCategory(
                                index: index,
                                categories: CategoryDataProvider.categories,
                                activeCategories: CategoryDataProvider.chosenCategory,
                              );
                          if (CategoryDataProvider.chosenCategory.isNotEmpty) {
                            context.read<ChooseCategoryBloc>().add(
                                  ChosenCategoryEvent(
                                    isEmpty: CategoryDataProvider.chosenCategory.isEmpty,
                                    chosenCategory: CategoryDataProvider.chosenCategory[0],
                                  ),
                                );
                          } else {
                            context.read<ChooseCategoryBloc>().add(
                                  UnchosenCategoryEvent(
                                    isEmpty: CategoryDataProvider.chosenCategory.isEmpty,
                                  ),
                                );
                          }
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
                chosenCategory: CategoryDataProvider.chosenCategory,
                title: AppString.save,
                onTap: () {
                  context.read<ChooseCategoryBloc>().add(
                        ChosenCategoryEvent(
                          isEmpty: CategoryDataProvider.chosenCategory.isEmpty,
                          chosenCategory: CategoryDataProvider.chosenCategory[0],
                        ),
                      );
                  Navigator.pop(context);
                },
              ),
            ],
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
        context.read<ChooseCategoryBloc>().add(
              UnchosenCategoryEvent(
                isEmpty: chosenCategory.isEmpty,
              ),
            );
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
            BlocBuilder<ChooseCategoryBloc, ChooseCategoryState>(
              builder: (context, state) {
                return category.isEnabled // Передаю категорию с текущим индексом чтобы выбиралась
                    // только одна, а не все
                    ? const SightIcons(
                        assetName: AppAssets.tick,
                        width: 24,
                        height: 24,
                      )
                    : const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
