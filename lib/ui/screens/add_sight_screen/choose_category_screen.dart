import 'package:flutter/material.dart';
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
