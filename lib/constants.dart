import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:color_convert/color_convert.dart';

Container kresistorEndWire(int side) {
  return Container(
      height: 10,
      width: 70,
      decoration: BoxDecoration(
          color: Colors.black,
          //the first wire has a BorderRadius on the left side while the second wire has a BorderRadius on the right side
          borderRadius: (side == 1)
              ? BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))
              : BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10))));
}

Container buildBandContainer(Color bandColor) {
  return Container(
    color: bandColor,
    width: 10,
  );
}

FadeTransition buildFadeTransition(Color bandColor, Animation<double> opacity) {
  return FadeTransition(opacity: opacity, child: buildBandContainer(bandColor));
}

Dialog buildDialog(
    {TextEditingController controller, Color color, Function onSubmit}) {
  return Dialog(
    elevation: 3.0,
    backgroundColor: Color(0xff3C444E),
    insetPadding: EdgeInsets.symmetric(horizontal: 65),
    child: TextField(
        style: TextStyle(color: Colors.white),
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

Container buildColorNameTextField(
    TextEditingController _controller, Color color, BuildContext context) {
  return Container(
    child: TextField(
        style: TextStyle(color: Colors.black),
        controller: _controller,
        cursorHeight: 26,
        cursorColor: color,
        textAlign: TextAlign.center,
        autocorrect: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText:
              convert.hex.keyword(color.value.toRadixString(16)).toString(),
        ),
        onSubmitted: (colorNameTyped) async {
          //using the color converter library/dependency to get the name of the color
          //convert its value to hex first
          List colorRGBValue() {
            var converted = convert.keyword.rgb(colorNameTyped.toLowerCase());
            //check if the color exists in the list
            //if it doesnt exist the method returns null.
            if ((converted.toString()) != null.toString()) {
              _controller.clear(); //clears the textfield
              context.runtimeType;
              return converted;
            } else {
              print('error');
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Wrong color name'),
                behavior: SnackBarBehavior.floating,
              ));

              _controller.clear();
            }
          }

          var colorName = colorRGBValue();
          //convert it to the accepted ARGB format for colors
          Color bandcolorSelected =
              Color.fromARGB(255, colorName[0], colorName[1], colorName[2]);

          //change the color of the selected band according to the color input
          //  await bandColorChange(bandcolorSelected);
        }),
  );
}

DropdownButton<int> androidDropdown({int totalBands, Function onChange}) {
  List<DropdownMenuItem<int>> dropDownMenuItems = [
    DropdownMenuItem(
      child: Text('3 bands'),
      value: 3,
    ),
    DropdownMenuItem(
      child: Text('4 bands'),
      value: 4,
    ),
    DropdownMenuItem(
      child: Text('5 bands'),
      value: 5,
    ),
    DropdownMenuItem(
      child: Text('6 bands'),
      value: 6,
    ),
  ];

  return DropdownButton<int>(
    value: totalBands,
    items: dropDownMenuItems,
    onChanged: onChange,
  );
}

// CupertinoPicker iOSPicker() {
//     List<Text> pickerItems = [Text('3'), Text('4'), Text('5'), Text('6')];

//     return CupertinoPicker(
//       backgroundColor: Colors.lightBlue,
//       itemExtent: 32.0,
//       onSelectedItemChanged: (selectedIndex) {
//         print(selectedIndex);
//       },
//       children: pickerItems,
//     );
//   }
