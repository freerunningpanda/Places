import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';

class SightCard extends StatelessWidget {
  final List<Sight> sight;
  const SightCard({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

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
            margin: const EdgeInsets.symmetric(horizontal: 16),
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
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: sight.length,
              itemBuilder: (context, index) {
                final item = sight[index];

                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      height: 192,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(245, 245, 245, 1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            child: Container(
                              width: w,
                              height: h * 0.145,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: NetworkImage(item.url),
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            top: 16,
                            child: Text(
                              item.type,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: SvgPicture.asset(
                              'resources/images/heart.svg',
                              height: 24,
                              width: 24,
                            ),
                          ),
                          Positioned(
                            left: 16,
                            bottom: h * 0.09,
                            child: SizedBox(
                              width: 296,
                              height: 16,
                              child: Text(
                                item.name,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(59, 62, 91, 1),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            bottom: h * 0.02,
                            child: SizedBox(
                              width: 296,
                              child: Text(
                                item.details,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(124, 126, 146, 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
