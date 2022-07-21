import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        width: 328,
        height: 72,
        child: RichText(
          maxLines: 2,
          text: const TextSpan(
            text: 'C',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.green,
            ),
            children: [
              TextSpan(
                text: 'писок',
                style: TextStyle(
                  color: Color.fromRGBO(59, 62, 91, 1),
                ),
                children: [
                  TextSpan(
                    text: '\nи',
                    style: TextStyle(
                      color: Colors.yellow,
                    ),
                    children: [
                      TextSpan(
                        text: 'нтересных ',
                        style: TextStyle(
                          color: Color.fromRGBO(59, 62, 91, 1),
                        ),
                        children: [
                          TextSpan(
                            text: 'м',
                            style: TextStyle(
                              color: Color.fromRGBO(37, 40, 73, 1),
                            ),
                            children: [
                              TextSpan(
                                text: 'ест',
                                style: TextStyle(
                                  color: Color.fromRGBO(59, 62, 91, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
