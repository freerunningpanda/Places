import 'package:flutter/material.dart';

import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_card.dart';

class SightListScreen extends StatelessWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = Mocks.mocks;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            width: double.infinity,
            height: 72,
            child: const Text(
              'Список \nинтересных мест',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(59, 62, 91, 1),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];

                return SightCard(
                  url: item.url,
                  type: item.type,
                  name: item.name,
                  details: item.details,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
