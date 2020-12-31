import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:color_convert/color_convert.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';

class ColorCodeCalculator extends StatefulWidget {
  @override
  _ColorCodeCalculatorState createState() => _ColorCodeCalculatorState();
}

class _ColorCodeCalculatorState extends State<ColorCodeCalculator> {
  Color bandColor1 = Colors.yellow;
  Color bandColor2 = Color.fromARGB(255, 0, 0, 255);
  Color bandColor3 = Color.fromARGB(255, 255, 0, 0);
  Color bandColor4 = Color.fromARGB(255, 0, 0, 0);
  Color bandColor5 = Colors.green;
  Color bandColor6 = Colors.brown;
  int totalBands = 5;

  Color testBandColor1 = Colors.orange;
  Color testBandColor2 = Colors.yellow;
  Color testBandColor3 = Colors.green;
  Color testBandColor4 = Colors.blue;
  Color testBandColor5 = Color(0xffEE82EE);
  Color testBandColor6 = Colors.grey;
  Color testBandColor7 = Colors.white;
  Color testBandColor8 = Color(0xffFFD700);
  Color testBandColor9 = Color(0xffC0C0C0);

  Color colorPickerColor;
  Color certainColor;
  bool selected1 = false;
  bool selected2 = false;
  bool selected3 = false;
  bool selected4 = false;
  bool selected5 = false;
  bool selected6 = false;

  // void matchColorToResistorValue(Color bandColor) {
  //   //  ff03040E
  //   if (bandColor.value <= 4278387726) {
  //     print('black');
  //   } else if (bandColor.value <= 4280391411) {
  //     print('blue');
  //   } else if (bandColor.value <= 4283215696) {
  //     print('green');
  //   } else if (bandColor.value <= 4286141768) {
  //     print('brown');
  //   } else if (bandColor.value <= 4288585374) {
  //     print('grey');
  //   } else if (bandColor.value <= 4293821166) {
  //     print('violet');
  //   } else if (bandColor.value <= 4294198070) {
  //     print('red');
  //   } else if (bandColor.value <= 4290822336) {
  //     print('silver');
  //   } else if (bandColor.value <= 4294940672) {
  //     print('orange');
  //   } else if (bandColor.value <= 4294956800) {
  //     print('gold');
  //   } else if (bandColor.value <= 4294961979) {
  //     print('yellow');
  //   } else if (bandColor.value <= 4294967295) {
  //     print('white');
  //   } else {
  //     print('not a color');
  //   }
  // }

  

  void matchColorToResistorValue(Color bandColor) {
    //  ff03040E
    if (bandColor.value == 4278387726) {
      print('black');
    } else if (bandColor.value == 4280391411) {
      print('blue');
    } else if (bandColor.value == 4283215696) {
      print('green');
    } else if (bandColor.value == 4286141768) {
      print('brown');
    } else if (bandColor.value == 4288585374) {
      print('grey');
    } else if (bandColor.value == 4293821166) {
      print('violet');
    } else if (bandColor.value == 4294198070) {
      print('red');
    } else if (bandColor.value == 4290822336) {
      print('silver');
    } else if (bandColor.value == 4294940672) {
      print('orange');
    } else if (bandColor.value == 4294956800) {
      print('gold');
    } else if (bandColor.value == 4294961979) {
      print('yellow');
    } else if (bandColor.value == 4294967295) {
      print('white');
    } else {
      print('not a color');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             androidDropdown(
                    totalBands: totalBands,
                    onChange: (int newValue) {
                      setState(() {
                        totalBands = newValue;
                      });
                    },
                  ),       
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  kresistorEndWire(2),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        height: 80,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width:
                                  40, //same as the container above it, reduced because of spaeceBetween
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected1 = !selected1;
                                  selected2 =
                                      selected3 = selected4 = selected5 = false;
                                });
                                print('selected 1 is $selected1');
                              },
                              child: buildBandContainer(bandColor1),
                            ),
                            //check the n.o bands selected.
                            (totalBands == 6 || totalBands == 5)
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected2 = !selected2;
                                        selected3 = selected4 =
                                            selected5 = selected6 = false;
                                      });

                                      print('selected 2 is $selected2');
                                    },
                                    child: buildBandContainer(bandColor2),
                                  )
                                : SizedBox.shrink(),
                            (totalBands == 4) ||
                                    (totalBands == 5) ||
                                    (totalBands == 6)
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected3 = !selected3;
                                        selected1 = selected2 = selected4 =
                                            selected5 = selected6 = false;
                                      });

                                      print('selected 3 is $selected3');
                                    },
                                    child: buildBandContainer(bandColor3))
                                : SizedBox.shrink(),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected4 = !selected4;
                                    selected1 = selected2 = selected3 =
                                        selected5 = selected6 = false;
                                  });
                                  print('selected 4 is $selected4');
                                },
                                child: buildBandContainer(bandColor4)),
                            (totalBands == 6)
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected5 = !selected5;
                                        selected1 = selected2 = selected3 =
                                            selected4 = selected6 = false;
                                      });

                                      print('selected 5 is $selected5');
                                    },
                                    child: buildBandContainer(bandColor5))
                                : SizedBox.shrink(),
                            SizedBox(
                              width:
                                  9, //the tolerance is further away from the other values
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected6 = !selected6;
                                  selected1 = selected2 =
                                      selected3 = selected4 = selected5 = false;
                                });
                                print('selected 6 is $selected6');
                              },
                              child: buildBandContainer(bandColor6),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        height: 80,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                        ),
                      ),
                    ],
                  ),
                  kresistorEndWire(1),
                ],
              ),
            ),
            CircleColorPicker(
              strokeWidth: 5,
              onChanged: bandColorChange,
              textStyle: TextStyle(
                color: bandColor1,
                fontSize: 30.0,
              ),
              colorCodeBuilder: (context, color) {
                var _controller = TextEditingController();
                return buildDialog(
                    controller: _controller,
                    color: color,
                    onSubmit: (colorNameTyped) {
                      //using the color converter library/dependency to get the name of the color
                      //convert its value to hex first
                      List colorRGBValue() {
                        var converted =
                            convert.keyword.rgb(colorNameTyped.toLowerCase());
                        //check if the color exists in the list
                        //if it doesnt exist the method returns null.
                        if ((converted.toString()) != null.toString()) {
                          print('no error');
                          _controller.clear(); //clears the textfield
                          return converted;
                        } else {
                          print('error');
                          _controller.clear();
                        }
                      }

                      var colorName = colorRGBValue();
                      //convert it to the accepted ARGB format for colors
                      Color bandcolorSelected = Color.fromARGB(
                          255, colorName[0], colorName[1], colorName[2]);

                      //change the color of the selected band according to the color input
                      bandColorChange(bandcolorSelected);
                    });
              },
            ),
            FlatButton(
                onPressed: () {
                  print(testBandColor1.value);

                  print('<<<<<<>>>>>>');

                  matchColorToResistorValue(bandColor1);
                },
                child: CupertinoPicker(
                    itemExtent: 2,
                    onSelectedItemChanged: null,
                    children: [Text('1'), Text('1')])),
          ],
        ),
      ),
    );
  }

  void bandColorChange(Color color) {
    if (selected1 == true) {
      setState(() {
        bandColor1 = color;
      });
    } else if (selected2 == true) {
      setState(() {
        bandColor2 = color;
      });
    } else if (selected3 == true) {
      setState(() {
        bandColor3 = color;
      });
    } else if (selected4 == true) {
      setState(() {
        bandColor4 = color;
      });
    } else if (selected5 == true) {
      setState(() {
        bandColor5 = color;
      });
    } else if (selected6 == true) {
      setState(() {
        bandColor6 = color;
      });
    }
  }
}

class ResistorBandGestureDetctr extends StatelessWidget {
  ResistorBandGestureDetctr(
      {Key key,
      @required this.selected1,
      @required this.selected2,
      @required this.selected3,
      @required this.bandColor,
      @required this.onTapR})
      : super(key: key);

  bool selected1;
  bool selected2;
  bool selected3;
  Color bandColor;
  Function onTapR;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapR,

      //   print(selected1);
      //   print('selected1');
      //   // colorChange();
      // ,
      child: Container(
        color: bandColor,
        width: 10,
      ),
    );
  }
}

class ResistorBand extends StatefulWidget {
  var _bandColor;
  //Color colorPickerColor;

  ResistorBand(this._bandColor);

  @override
  _ResistorBandState createState() => _ResistorBandState();
}

class _ResistorBandState extends State<ResistorBand> {
  Widget colorChange() {
    return CircleColorPicker(
      onChanged: (Color color) {
        setState(() {
          widget._bandColor = color;
        });
      },
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 30.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool selected = false;

    return GestureDetector(
      onTap: () {
        setState(() {
          selected = true;
        });
        // setState(() {
        //   widget._bandColor = widget.colorPickerColor;
        // });
        print(selected);
        print('greenAccent');
        // colorChange();
      },
      child: Container(
        color: widget._bandColor,
        width: 10,
      ),
    );
  }
}
