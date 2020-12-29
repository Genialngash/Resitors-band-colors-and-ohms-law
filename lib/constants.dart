import 'package:flutter/material.dart';
import 'package:color_convert/color_convert.dart';

Container kresistorEndWire(int side) {
  return Container(
    height: 10,
    width: 70,
    decoration: BoxDecoration(
        color: Colors.black,
        //the first wire has a BorderRadius on the left side while the second wire has a BorderRadius on the right side
        borderRadius: (side ==1)?BorderRadius.only(
             topRight: Radius.circular(10), bottomRight: Radius.circular(10)):
           BorderRadius.only(  topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
             
  ));
}

Container buildBandContainer(Color bandColor) {
  return Container(
    color: bandColor,
    width: 10,
  );
}

Dialog buildDialog(
    {TextEditingController controller, Color color, Function onSubmit}) {
  return Dialog(
    elevation: 3.0,
    backgroundColor: Colors.blueGrey,
    insetPadding: EdgeInsets.symmetric(horizontal: 65),
    child: TextField(
        controller: controller,
        cursorHeight: 26,
        cursorColor: color,
        textAlign: TextAlign.center,
        autocorrect: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText:
              convert.hex.keyword(color.value.toRadixString(16)).toString(),
        ),
        onSubmitted: onSubmit),
  );
}
