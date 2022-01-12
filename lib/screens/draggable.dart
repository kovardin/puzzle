import 'package:flutter/material.dart';

class DraggableScreen extends StatelessWidget {
  const DraggableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Dragg(
              data: 1,
            ),
            DragTarget<int>(
              onAccept: (item) {
                print(item);
              },
              builder: (context, candidates, rejected) {
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[300],
                );
              },
            ),
            Dragg(
              data: 2,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Dragg extends StatelessWidget {
  const Dragg({
    Key? key,
    required this.data,
  }) : super(key: key);

  final int data;

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      axis: Axis.vertical,
      data: data,
      feedback: Material(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.grey,
          child: Center(child: Text('$data')),
        ),
      ),
      child: Container(
        width: 100,
        height: 100,
        color: Colors.grey,
        child: Center(child: Text('$data')),
      ),
      childWhenDragging: Container(
        width: 100,
        height: 100,
        color: Colors.grey[200],
      ),
    );
  }
}
