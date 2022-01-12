import 'package:flutter/material.dart';

class Slidable extends StatefulWidget {
  final ValueChanged<double> valueChanged;

  Slidable({required this.valueChanged});

  @override
  SlidableState createState() {
    return new SlidableState();
  }
}

class SlidableState extends State<Slidable> {
  ValueNotifier<double> valueListener = ValueNotifier(.0);

  @override
  void initState() {
    valueListener.addListener(notifyParent);
    super.initState();
  }

  void notifyParent() {
    if (widget.valueChanged != null) {
      widget.valueChanged(valueListener.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Builder(
        builder: (context) {
          return AnimatedBuilder(
            animation: valueListener,
            builder: (context, child) {
              return Align(
                alignment: Alignment(valueListener.value * 2 - 1, .5),
                child: child,
              );
            },
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                valueListener.value = (valueListener.value +
                    details.delta.dx / (context.size?.width ?? 1))
                    .clamp(.0, 1.0);
              },
              child: FlutterLogo(size: 50.0),
            ),
          );
        },
      ),
    );
  }
}
