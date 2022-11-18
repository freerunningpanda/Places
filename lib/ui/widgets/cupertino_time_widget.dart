import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoTimeWidget extends StatefulWidget {
  const CupertinoTimeWidget({Key? key}) : super(key: key);

  @override
  State<CupertinoTimeWidget> createState() => _CupertinoTimeWidgetState();
}

class _CupertinoTimeWidgetState extends State<CupertinoTimeWidget> {
  // ignore: unused_field
  final mode = CupertinoDatePickerMode.dateAndTime;

  DateTime? _duration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size.height / 2.48),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: CupertinoDatePicker(
                onDateTimeChanged: (selected) {
                  setState(
                    () {
                      _duration = selected;
                    },
                  );
                },
                mode: mode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: size.width / 3,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  color: theme.iconTheme.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
