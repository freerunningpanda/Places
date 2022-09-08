import 'package:flutter/material.dart';

import 'package:places/appsettings.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';
import 'package:places/ui/widgets/action_button.dart';
import 'package:places/ui/widgets/sight_icons.dart';
import 'package:provider/provider.dart';

class AddSightScreen extends StatelessWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final latFocus = context.read<AppSettings>().latFocus;
    final titleController = context.read<AppSettings>().titleController;
    final descriptionController = context.read<AppSettings>().descriptionController;
    final titleFocus = context.read<AppSettings>().titleFocus;
    final descriptionFocus = context.read<AppSettings>().descriptionFocus;
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final cancel = GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Text(
        AppString.cancel,
        style: theme.textTheme.displayLarge,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 18, right: 16.0, bottom: 8.0),
            child: Column(
              children: [
                _NewPlaceAppBar(
                  theme: theme,
                  width: width / 4.5,
                  leading: cancel,
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
                      onSubmitted: (v) => latFocus.requestFocus(),
                    ),
                    const SizedBox(height: 24),
                    _CoordinatsInputWidget(
                      theme: theme,
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
                    ),
                    const SizedBox(height: 124),
                    ActionButton(
                      title: AppString.create,
                      onTap: () {
                        debugPrint('🟡---------create btn pressed');
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
  final OnSubmitted onSubmitted;

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

  const _CoordinatsInputWidget({
    Key? key,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final latFocus = context.read<AppSettings>().latFocus;
    final lotFocus = context.read<AppSettings>().lotFocus;
    final latController = context.read<AppSettings>().latController;
    final lotController = context.read<AppSettings>().lotController;
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
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _LatLotWidget(
            focusNode: lotFocus,
            theme: theme,
            title: AppString.lot,
            onSubmitted: (v)  => focus.goToDescription(),
            controller: lotController,
            onTap: focus.tapOnLot,
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
  final OnSubmitted onSubmitted;
  final TextEditingController controller;
  final VoidCallback onTap;

  const _LatLotWidget({
    Key? key,
    required this.theme,
    required this.title,
    required this.focusNode,
    required this.onSubmitted,
    required this.controller,
    required this.onTap,
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

class _NewPlaceAppBar extends StatelessWidget {
  final ThemeData theme;
  final double width;
  final Widget leading;
  const _NewPlaceAppBar({
    Key? key,
    required this.theme,
    required this.width,
    required this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leading,
        SizedBox(
          width: width,
        ),
        Text(
          AppString.newPlace,
          style: theme.textTheme.titleLarge,
        ),
      ],
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
    return Column(
      children: [
        Row(
          children: [
            Text(
              AppString.category,
              style: theme.textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppString.nochoose,
              style: theme.textTheme.titleMedium,
            ),
            const Icon(
              Icons.chevron_right,
              size: 25,
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(),
      ],
    );
  }
}
