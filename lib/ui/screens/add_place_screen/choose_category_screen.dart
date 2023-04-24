import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/choose_category_bloc/choose_category_bloc.dart';
import 'package:places/cubits/create_place/create_place_button_cubit.dart';
import 'package:places/data/model/category.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/widgets/new_place_app_bar_widget.dart';
import 'package:places/ui/widgets/place_icons.dart';
import 'package:places/ui/widgets/save_button.dart';

class ChooseCategoryWidget extends StatelessWidget {
  final List<Category> categories;
  final List<Category> chosenCategories;
  const ChooseCategoryWidget({
    Key? key,
    required this.categories,
    required this.chosenCategories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 18, right: 16.0, bottom: 8.0),
          child: Column(
            children: [
              NewPlaceAppBarWidget(
                theme: theme,
                width: width / 3.5,
                leading: _BackButtonWidget(
                  chosenCategory: chosenCategories,
                ),
                title: AppStrings.category,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  child: ListView.separated(
                    physics: Platform.isAndroid ? const ClampingScrollPhysics() : const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      final category = categories[index];

                      return _ItemCategory(
                        name: category.title,
                        theme: theme,
                        isEnabled: category.isEnabled,
                        category: category,
                        onTap: () {
                          context.read<ChooseCategoryBloc>().chooseCategory(
                                index: index,
                                categories: categories,
                                activeCategories: chosenCategories,
                              );
                          if (chosenCategories.isNotEmpty) {
                            context.read<ChooseCategoryBloc>().add(
                                  ChosenCategoryEvent(
                                    isEmpty: chosenCategories.isEmpty,
                                    chosenCategory: chosenCategories[0],
                                    placeType: chosenCategories[0].placeType,
                                  ),
                                );
                          } else {
                            context.read<ChooseCategoryBloc>().add(
                                  UnchosenCategoryEvent(
                                    isEmpty: chosenCategories.isEmpty,
                                  ),
                                );
                          }
                        },
                      );
                    },
                    separatorBuilder: (_, index) {
                      return const Divider();
                    },
                    itemCount: categories.length,
                  ),
                ),
              ),
              const Divider(),
              SizedBox(height: height * 0.3),
              SaveButton(
                chosenCategory: chosenCategories,
                title: AppStrings.save,
                onTap: () {
                  context.read<ChooseCategoryBloc>().add(
                        ChosenCategoryEvent(
                          isEmpty: chosenCategories.isEmpty,
                          chosenCategory: chosenCategories[0],
                          placeType: chosenCategories[0].placeType,
                        ),
                      );
                  context.read<CreatePlaceButtonCubit>().updateButtonState(
                        titleValue: '',
                        descriptionValue: '',
                        latValue: '',
                        lotValue: '',
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
  final List<Category> chosenCategory;
  const _BackButtonWidget({
    Key? key,
    required this.chosenCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () {
        context.read<CreatePlaceButtonCubit>().updateButtonState(
              titleValue: '',
              descriptionValue: '',
              latValue: '',
              lotValue: '',
            );
        context.read<ChooseCategoryBloc>().resetCategoryState(activeCategories: chosenCategory);
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
              builder: (_, state) {
                return category.isEnabled // Передаю категорию с текущим индексом чтобы выбиралась
                    // только одна, а не все
                    ? const PlaceIcons(
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
