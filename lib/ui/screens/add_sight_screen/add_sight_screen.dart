import 'package:flutter/material.dart';

import 'package:places/appsettings.dart';
import 'package:places/data/categories_table.dart';
import 'package:places/data/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/screens/add_sight_screen/choose_category_screen.dart';
import 'package:places/ui/widgets/action_button.dart';
import 'package:places/ui/widgets/new_place_app_bar_widget.dart';
import 'package:places/ui/widgets/sight_icons.dart';
import 'package:provider/provider.dart';

String name = '';
double lat = 0;
double lot = 0;
String details = '';
String type = '';

class AddSightScreen extends StatelessWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final latController = context.read<AppSettings>().latController;
    final lotController = context.read<AppSettings>().lotController;
    final latFocus = context.read<AppSettings>().latFocus;
    final lotFocus = context.read<AppSettings>().lotFocus;
    final titleController = context.read<AppSettings>().titleController;
    final descriptionController = context.read<AppSettings>().descriptionController;
    final titleFocus = context.read<AppSettings>().titleFocus;
    final descriptionFocus = context.read<AppSettings>().descriptionFocus;
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 18, right: 16.0, bottom: 8.0),
            child: Column(
              children: [
                NewPlaceAppBarWidget(
                  theme: theme,
                  width: width / 4.5,
                  leading: _CancelButtonWidget(theme: theme),
                  title: AppString.newPlace,
                ),
                const SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CategoryChooseWidget(theme: theme),
                    const SizedBox(height: 16),
                    _TextInputWidget(
                      theme: theme,
                      title: AppString.title,
                      height: 40,
                      suffixIcon: _SuffixIcon(controller: titleController, theme: theme),
                      focusNode: titleFocus,
                      controller: titleController,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (value) => latFocus.requestFocus(),
                      onChanged: (value) => name = value,
                    ),
                    const SizedBox(height: 24),
                    _CoordinatsInputWidget(
                      latController: latController,
                      lotController: lotController,
                      theme: theme,
                      latFocus: latFocus,
                      lotFocus: lotFocus,
                    ),
                    const SizedBox(height: 15),
                    const _PointOnMapWidget(),
                    const SizedBox(height: 37),
                    _TextInputWidget(
                      theme: theme,
                      title: AppString.description,
                      hintText: AppString.enterTheText,
                      maxLines: 5,
                      height: 80,
                      focusNode: descriptionFocus,
                      controller: descriptionController,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) => details = value,
                    ),
                    const SizedBox(height: 124),
                    ActionButton(
                      title: AppString.create,
                      onTap: () {
                        debugPrint('🟡---------create btn pressed');
                        Mocks.mocks.add(
                          Sight(
                            name: name,
                            lat: lat,
                            lot: lot,
                            details: details,
                            type: CategoriesTable.chosenCategory[0].title,
                          ),
                        );
                        titleController.clear();
                        descriptionController.clear();
                        latController.clear();
                        lotController.clear();
                        debugPrint('🟡---------Создан объект: ${Mocks.mocks[7]}');
                      },
                      counterValue: 0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CancelButtonWidget extends StatelessWidget {
  final ThemeData theme;

  const _CancelButtonWidget({
    Key? key,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Navigator.pop(context),
      child: Text(
        AppString.cancel,
        style: theme.textTheme.displayLarge,
      ),
    );
  }
}

class _TextInputWidget extends StatefulWidget {
  final ThemeData theme;
  final String? hintText;
  final String title;
  final int? maxLines;
  final double height;
  final FocusNode focusNode;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final VoidFuncString onSubmitted;
  final VoidFuncString onChanged;

  const _TextInputWidget({
    Key? key,
    required this.theme,
    this.hintText,
    required this.title,
    this.maxLines,
    required this.height,
    required this.focusNode,
    this.suffixIcon,
    required this.controller,
    required this.textInputAction,
    required this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  State<_TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<_TextInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: widget.theme.textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: widget.height,
          child: TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            textCapitalization: TextCapitalization.sentences,
            cursorColor: widget.theme.focusColor,
            cursorWidth: 1,
            maxLines: widget.maxLines,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTypography.textText16Search,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: widget.theme.sliderTheme.activeTrackColor as Color),
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.theme.sliderTheme.activeTrackColor as Color),
                borderRadius: BorderRadius.circular(8.0),
              ),
              suffixIcon: widget.focusNode.hasFocus ? widget.suffixIcon : null,
            ),
            onSubmitted: widget.onSubmitted,
          ),
        ),
      ],
    );
  }
}

class _PointOnMapWidget extends StatelessWidget {
  const _PointOnMapWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      AppString.pointOnTheMap,
      style: AppTypography.clearButton,
    );
  }
}

class _CoordinatsInputWidget extends StatelessWidget {
  final ThemeData theme;
  final TextEditingController latController;
  final TextEditingController lotController;
  final FocusNode latFocus;
  final FocusNode lotFocus;

  const _CoordinatsInputWidget({
    Key? key,
    required this.theme,
    required this.latController,
    required this.lotController,
    required this.latFocus,
    required this.lotFocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final focus = context.watch<AppSettings>();

    return Row(
      children: [
        Expanded(
          child: _LatLotWidget(
            focusNode: latFocus,
            theme: theme,
            title: AppString.lat,
            onSubmitted: (v) => focus.goToLat(),
            controller: latController,
            onTap: focus.tapOnLat,
            onChanged: (value) => lat = double.parse(value),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _LatLotWidget(
            focusNode: lotFocus,
            theme: theme,
            title: AppString.lot,
            onSubmitted: (v) => focus.goToDescription(),
            controller: lotController,
            onTap: focus.tapOnLot,
            onChanged: (value) => lot = double.parse(value),
          ),
        ),
      ],
    );
  }
}

class _LatLotWidget extends StatefulWidget {
  final ThemeData theme;
  final String title;
  final FocusNode focusNode;
  final VoidFuncString onSubmitted;
  final TextEditingController controller;
  final VoidCallback onTap;
  final VoidFuncString onChanged;

  const _LatLotWidget({
    Key? key,
    required this.theme,
    required this.title,
    required this.focusNode,
    required this.onSubmitted,
    required this.controller,
    required this.onTap,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<_LatLotWidget> createState() => _LatLotWidgetState();
}

class _LatLotWidgetState extends State<_LatLotWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            Text(
              widget.title,
              style: widget.theme.textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: TextField(
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            focusNode: widget.focusNode,
            keyboardType: TextInputType.number,
            controller: widget.controller,
            cursorColor: widget.theme.focusColor,
            cursorWidth: 1,
            style: widget.theme.textTheme.bodyLarge,
            textInputAction: TextInputAction.next,
            onSubmitted: widget.onSubmitted,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 16.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: widget.theme.sliderTheme.activeTrackColor as Color),
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.theme.sliderTheme.activeTrackColor as Color),
                borderRadius: BorderRadius.circular(8.0),
              ),
              suffixIcon: widget.focusNode.hasFocus
                  ? _SuffixIcon(
                      controller: widget.controller,
                      theme: widget.theme,
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

class _SuffixIcon extends StatelessWidget {
  final TextEditingController controller;
  final ThemeData theme;

  const _SuffixIcon({
    Key? key,
    required this.controller,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: controller.clear,
        child: SightIcons(
          assetName: AppAssets.clearDark,
          width: 20,
          height: 20,
          color: theme.iconTheme.color,
        ),
      ),
    );
  }
}

class _CategoryChooseWidget extends StatelessWidget {
  final ThemeData theme;

  const _CategoryChooseWidget({
    Key? key,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<AppSettings>().updateCategory();

    return Column(
      children: [
        Row(
          children: [
            Text(
              AppString.category.toUpperCase(),
              style: theme.textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: 14),
        InkWell(
          onTap: () => Navigator.of(context).push<ChooseCategoryWidget>(
            MaterialPageRoute(
              builder: (context) => const ChooseCategoryWidget(),
            ),
          ),
          child: SizedBox(
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (CategoriesTable.chosenCategory.isEmpty)
                  Text(
                    AppString.nochoose,
                    style: theme.textTheme.titleMedium,
                  )
                else
                  Text(
                    CategoriesTable.chosenCategory[0].title,
                    style: theme.textTheme.titleMedium,
                  ),
                const Icon(
                  Icons.chevron_right,
                  size: 25,
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
