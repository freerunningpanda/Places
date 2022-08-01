import 'package:flutter/material.dart';

import 'package:places/advanced_tab_demo.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: 
      const VisitingScreen(),
      // const SightListScreen(),
    );
  }
}

class TabBar extends StatefulWidget {
  const TabBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AdvancedTabDemoState();
  }
}
