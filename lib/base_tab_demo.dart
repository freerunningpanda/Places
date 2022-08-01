import 'package:flutter/material.dart';

class BaseTabDemoState extends State {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Text Demo App'),
          bottom: const TabBar(tabs: [
            Tab(
              child: Text('Tab 1'),
            ),
            Tab(
              child: Text('Tab 2'),
            ),
          ]),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Tab 1 Content')),
            Center(child: Text('Tab 2 Content')),
          ],
        ),
      ),
    );
  }
}
