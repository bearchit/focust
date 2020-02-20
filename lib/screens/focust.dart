import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

class FocustScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: 30.0, bottom: 15.0),
            child: Center(
              child: buildCircle(context),
            )),
        Container(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: Center(
            child: Text("Develop task management"),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 0, bottom: 15.0),
          child: Center(
              child: GFButton(
            onPressed: () {},
            text: "Primary",
          )),
        )
      ],
    );
  }

  Widget buildCircle(BuildContext context) {
    return Container(
      width: 250.0,
      height: 250.0,
      decoration: BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle,
      ),
    );
  }
}
