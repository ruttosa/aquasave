import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../common/constant.dart';

final List<String> savingTips = SAVING_TIPS;

final List<Widget> imageSliders = savingTips
    .map((item) => Stack(
          children: [
            // Card
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Card(
                color: const Color.fromARGB(255, 20, 101, 167),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                item,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Fuzzy Bubbles'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Card Icon
            Container(
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 20, 101, 167),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  // ignore: prefer_const_constructors
                  BoxShadow(blurRadius: 2, offset: const Offset(2, 2)),
                ],
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.tips_and_updates_rounded,
                  size: 38,
                  color: Colors.yellow[600],
                ),
              ),
            ),
          ],
        ))
    .toList();

class CarouselChangeReasonDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselChangeReasonDemoState();
  }
}

class _CarouselChangeReasonDemoState extends State<CarouselChangeReasonDemo> {
  String reason = '';
  final CarouselController _controller = CarouselController();

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      reason = changeReason.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
              autoPlayInterval: const Duration(seconds: 8),
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              onPageChanged: onPageChange,
              autoPlay: true,
            ),
            carouselController: _controller,
          ),
        )
      ],
    );
  }
}
