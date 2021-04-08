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

Dialog buildTextDialog(
    {TextEditingController controller, Color color, Function onSubmit}) {
  return Dialog(
    elevation: 3.0,
    //backgroundColor: Color(0xff062424),
    backgroundColor: Colors.blueGrey,
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
    dropdownColor: Color(0xff194644),
    iconEnabledColor: Colors.cyan,
    style: textStyling(),
    value: totalBands,
    items: dropDownMenuItems,
    onChanged: onChange,
  );
}

void buildSnackbar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
  ));
}

// ElevatedButton ele(){
//   return ElevatedButton(onPressed: onPressed, child: child,style: ButtonStyle(),)
// }

RaisedButton buildRaisedButton({Function onPressed}) {
  return RaisedButton(
    onPressed: onPressed,
    color: Color(0xff194649),
    splashColor: Colors.cyan,
    animationDuration: Duration(seconds: 1),
    child:Text('CALCULATE',style: textStyling(),),
  );
}

TextStyle textStyling({double fontSize}) {
  return TextStyle(
    color: Color(0xffD9D9E3),
    fontWeight: FontWeight.w500,
    fontSize: fontSize,
  );
}

Container buildSmdEndContainer() {
  return Container(
    decoration: BoxDecoration(
        color: Colors.grey, boxShadow: [BoxShadow(blurRadius: 4)]),
    height: 135,
    width: 30,
  );
}


ListTile  buildOhmsLawListile({TextEditingController controller,String hintText,
Function onChangeTextField,List<DropdownMenuItem<num>> dropdownMenuItems,
Function onChangeDropDown, var dropDownValue}){

  return ListTile(
              title: TextField(
                cursorWidth: 3.5,
                keyboardType: TextInputType.numberWithOptions(),
                controller: controller,
                maxLength: 14,
                maxLines: null,
                cursorColor: Color(0xff98DEDA),
                style: textStyling(fontSize: 30),
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: hintText,
                  counter: Offstage(),
                ),
                onChanged: onChangeTextField,
              ),
              trailing: DropdownButton(
                dropdownColor: Color(0xff194644),
                 iconEnabledColor: Colors.cyan,
                items: dropdownMenuItems,
                style: textStyling(),
                underline: Offstage(),
                onChanged: onChangeDropDown,

                value: dropDownValue,
              ),
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
