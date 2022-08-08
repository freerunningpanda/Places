import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/sight_list_screen.dart';

import 'package:places/ui/screen/visiting_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home:
          // const VisitingScreen(),
          SightListScreen(),
    );
  }
}
