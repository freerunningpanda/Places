import 'package:flutter/material.dart';

import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_card.dart';

class SightListScreen extends StatelessWidget {
  final List<Sight> sight;
  const SightListScreen({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              itemCount: 5,
              itemBuilder: (context, index) {
                final item = sight[index];

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
