import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class SightCard extends StatelessWidget {
  final String url;
  final String type;
  final String name;
  final String details;
  const SightCard({
    Key? key,
    required this.url,
    required this.type,
    required this.name,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
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
                      image: NetworkImage(url),
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
                  type,
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
                    name,
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
                    details,
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
  }
}
