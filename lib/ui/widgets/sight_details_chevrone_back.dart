import 'package:flutter/material.dart';

class SightDetailsChevroneBack extends StatelessWidget {
  const SightDetailsChevroneBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.chevron_left,
          color: Color.fromRGBO(37, 40, 73, 1),
          size: 25,
        ),
      ),
    );
  }
}
