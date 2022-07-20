import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MySecondWidget(),
    );
  }
}

class MyFirstWidget extends StatelessWidget {
  const MyFirstWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildCounter();
    withoutArgument();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: const Center(
        child: Text('Hello!'),
      ),
    );
  }
  
  void withoutArgument() {
    context.runtimeType;
        print(result);
  }

  void buildCounter() {
    var counter = 0;
    print(counter++);
  }
}

class MySecondWidget extends StatefulWidget {
  const MySecondWidget({Key? key}) : super(key: key);

  @override
  State<MySecondWidget> createState() => _MySecondWidgetState();
}

class _MySecondWidgetState extends State<MySecondWidget> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    buildCounter();
    withoutArgument();

    return const Center(
      child: Text('Hello!'),
    );
  }

  void withoutArgument() {
    var result = context.runtimeType;
    print(result);
  }

  void buildCounter() {
    print(_counter++);
  }
}
