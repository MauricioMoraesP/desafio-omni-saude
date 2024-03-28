import 'package:flutter/material.dart';

//Widget buttonChangeComponent
class buttonChangeComponent extends StatelessWidget {
  final Function() alternarValores;
  const buttonChangeComponent(this.alternarValores);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
      child: Column(
        children: [
          ElevatedButton(
              onPressed: alternarValores, child: Icon(Icons.swipe_left_sharp)),
        ],
      ),
    );
  }
}
