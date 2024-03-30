import 'package:flutter/material.dart';

//Widget ButtonChangeComponent
class ButtonChangeComponent extends StatelessWidget {
  final Function() alternarValores;
  const ButtonChangeComponent(this.alternarValores);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
      child: Column(
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: (Colors.amber)),
              onPressed: alternarValores,
              child: Icon(
                Icons.swipe_left_sharp,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
