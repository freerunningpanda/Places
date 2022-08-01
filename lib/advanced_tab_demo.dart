import 'package:flutter/material.dart';

class AdvancedTabDemoState extends State with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Demo App'),
        bottom: PreferredSize(
          child: CustomTabIndicator(tabController: tabController),
          preferredSize: const Size.fromHeight(48),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          Center(child: Text('Tab 1 Content')),
          Center(child: Text('Tab 2 Content')),
          Center(child: Text('Tab 3 Content')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.red,
        currentIndex: tabController.index,
        onTap: (currentIndex) {
          tabController.animateTo(currentIndex);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            label: 'Comment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Delete',
          ),
        ],
      ),
    );
  }
}

class CustomTabIndicator extends StatelessWidget {
  final TabController tabController;

  const CustomTabIndicator({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < tabController.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tabController.index == i ? Colors.red : Colors.grey,
              ),
              width: 15,
              height: 15,
            ),
          ),
      ],
    );
  }
}
