import 'package:flutter/material.dart';
import 'package:puzzle/components/slider.dart';

class SlidableScreen extends StatelessWidget {
  const SlidableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Slidable(
          valueChanged: (double value) {
            print(value);
          },
        ),
      ),
    );
  }
}
