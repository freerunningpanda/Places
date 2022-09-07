import 'package:flutter/material.dart';
import 'package:places/main.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_typography.dart';

class AddSightScreen extends StatelessWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 18, right: 16.0),
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
                  _TitleWidget(theme: theme),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: _LatLotWidget(
                          theme: theme,
                          title: AppString.lat,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _LatLotWidget(
                          theme: theme,
                          title: AppString.lot,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    AppString.pointOnTheMap,
                    style: AppTypography.clearButton,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LatLotWidget extends StatelessWidget {
  final ThemeData theme;
  final String title;

  const _LatLotWidget({
    Key? key,
    required this.theme,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            Text(
              title,
              style: theme.textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: TextField(
            cursorColor: Colors.black,
            cursorWidth: 1,
            style: theme.textTheme.bodyLarge,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 16.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: theme.sliderTheme.activeTrackColor as Color),
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.sliderTheme.activeTrackColor as Color),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
      ],
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

class _TitleWidget extends StatelessWidget {
  final ThemeData theme;
  const _TitleWidget({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            Text(
              AppString.title,
              style: theme.textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: TextField(
            cursorColor: Colors.black,
            cursorWidth: 1,
            style: theme.textTheme.bodyLarge,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 16.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: theme.sliderTheme.activeTrackColor as Color),
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.sliderTheme.activeTrackColor as Color),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
