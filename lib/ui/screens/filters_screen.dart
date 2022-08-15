import 'package:flutter/material.dart';
import 'package:places/main.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/widgets/sight_icons.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 24,
          right: 16,
          bottom: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Title(),
            Expanded(child: _FiltersTable()),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppString.categories,
      style: AppTypography.categoriesGrey,
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(80); // Это свойство не применяется

  const _AppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: AppBar(
        leading: IconButton(
          onPressed: () {
            debugPrint('chevrone back pressed');
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left),
          color: Theme.of(context).iconTheme.color,
        ),
        toolbarHeight: 86,
        bottomOpacity: 0.0,
        actions: const [
          _ClearButtonWidget(),
        ],
      ),
    );
  }
}

class _ClearButtonWidget extends StatelessWidget {
  const _ClearButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        debugPrint('clear Button pressed');
      },
      child: const Text(
        AppString.clear,
        style: AppTypography.clearButton,
      ),
    );
  }
}

class _FiltersTable extends StatefulWidget {
  const _FiltersTable({Key? key}) : super(key: key);

  @override
  State<_FiltersTable> createState() => _FiltersTableState();
}

class _FiltersTableState extends State<_FiltersTable> {
  final List<String> filters = ['Отель', 'Ресторан', 'Особое место', 'Парк', 'Музей', 'Кафе'];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0.0, -0.8),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 24,
        runSpacing: 40,
        children: filters.map((e) => _ItemFilter(title: e)).toList(),
      ),
    );
  }
}

class _ItemFilter extends StatelessWidget {
  final String title;
  const _ItemFilter({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      height: 96,
      child: Column(
        children: [
          const SizedBox(
            height: 64,
            width: 64,
            child: CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.bed),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
