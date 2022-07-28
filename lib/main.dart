import 'package:flutter/material.dart';
import 'package:places/ui/screen/sight_details.dart';

import 'package:places/ui/screen/sight_list_screen.dart';



void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SightDetails(
      ),
    );
  }
}


