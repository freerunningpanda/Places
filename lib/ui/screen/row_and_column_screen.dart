import 'package:flutter/material.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 50,
        color: Colors.red,
      ),
      // Stack(
      //   clipBehavior: Clip.none,
      //   fit: StackFit.passthrough,
      //   children: [
      //     Container(
      //       height: 500,
      //       width: 300,
      //       color: Colors.red,
      //     ),
      //     Container(
      //       height: 400,
      //       width: 250,
      //       color: Colors.green,
      //     ),
      //     Positioned(
      //       bottom: 20,
      //       right: -20,
      //       child: Container(
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(100),
      //           color: Colors.white,
      //         ),
      //         height: 200,
      //         width: 200,
      //       ),
      //     ),
      //     Container(
      //       height: 300,
      //       width: 100,
      //       color: Colors.blue,
      //     ),
      //   ],
      // ),
    );
    // UnconstrainedBox(
    //   child: ConstrainedBox(
    //     constraints: const BoxConstraints(
    //       minWidth: 200,
    //       minHeight: 100,
    //     ),
    //     child: Container(
    //       transform: Matrix4.rotationZ(-0.2),
    //       padding: const EdgeInsets.all(8),
    //       margin: const EdgeInsets.all(8),
    //       color: Colors.red,
    //       child: Container(
    //         transform: Matrix4.rotationZ(0.2),
    //         color: Colors.blue,
    //       ),
    //     ),
    //   ),
    // );
  }
}
