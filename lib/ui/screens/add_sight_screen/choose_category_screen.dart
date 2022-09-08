import 'package:flutter/material.dart';

import 'package:places/data/categories_table.dart';
import 'package:places/ui/widgets/new_place_app_bar_widget.dart';

class ChooseCategoryWidget extends StatefulWidget {
  const ChooseCategoryWidget({Key? key}) : super(key: key);

  @override
  State<ChooseCategoryWidget> createState() => _ChooseCategoryWidgetState();
}

class _ChooseCategoryWidgetState extends State<ChooseCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
                leading: const _BackButtonWidget(),
              ),
              const SizedBox(height: 40),
              Column(
                children: CategoriesTable.categories
                    .asMap()
                    .map(
                      (i, e) => MapEntry(
                        i,
                        _ItemCategory(name: e.title),
                      ),
                    )
                    .values
                    .toList(),
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
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () => Navigator.pop(context),
      child: const Icon(Icons.chevron_left),
    );
  }
}

class _ItemCategory extends StatelessWidget {
  final String name;
  const _ItemCategory({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(name),
      ],
    );
  }
}
