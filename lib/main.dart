import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/screen/res/themes.dart';
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
  bool isDarkMode = true;

  @override
  void initState() {
    if (isDarkMode) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: AppColors.darkThemeBgColor,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: AppColors.black,
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: darkTheme,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: 
        VisitingScreen(isDarkMode: isDarkMode),
        // SightListScreen(isDarkMode: isDarkMode),
      ),
    );
  }
}
