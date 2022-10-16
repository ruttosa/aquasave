import 'package:flutter/material.dart';

import '../../common/BottomMenuWidget.dart';

class AquasaveScreen extends StatelessWidget {
  const AquasaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 101, 167),
        title: const Text("Aquasave"),
      ),
      body: Container(),
      bottomNavigationBar: const MenuBottomWidget(),
    );
  }
}
