import 'dart:math';
import 'package:flutter/material.dart';
import 'package:color/color.dart' as color;

import 'package:color_convert/color_convert.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';

class ColorCodeCalculator extends StatefulWidget {
  @override
  _ColorCodeCalculatorState createState() => _ColorCodeCalculatorState();
}

class _ColorCodeCalculatorState extends State<ColorCodeCalculator> {
  Color bandColor1 = Color(0xffff0000);
  Color bandColor2 = Color.fromARGB(255, 0, 128, 0);
  Color bandColor3 = Color.fromARGB(255, 0, 0, 255);
  Color bandColor4 = Color.fromARGB(255, 0, 0, 255);
  Color bandColor5 = Color.fromARGB(255, 0, 0, 255);
  Color bandColor6 = Color.fromARGB(255, 0, 0, 255);
  int totalBands = 4;

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

  void matchColorToResistorValue(Color bandColor) {
    //  ff03040E
    if (bandColor.value <= 4278387726) {
      print('black');
    } else if (bandColor.value <= 4280391411) {
      print('blue');
    } else if (bandColor.value <= 4283215696) {
      print('green');
    } else if (bandColor.value <= 4286141768) {
      print('brown');
    } else if (bandColor.value <= 4288585374) {
      print('grey');
    } else if (bandColor.value <= 4293821166) {
      print('violet');
    } else if (bandColor.value <= 4294198070) {
      print('red');
    } else if (bandColor.value <= 4290822336) {
      print('silver');
    } else if (bandColor.value <= 4294940672) {
      print('orange');
    } else if (bandColor.value <= 4294956800) {
      print('gold');
    } else if (bandColor.value <= 4294961979) {
      print('yellow');
    } else if (bandColor.value <= 4294967295) {
      print('white');
    } else {
      print('not a color');
    }
  }

  var resistorBandList = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 10,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                  ),
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
                            (totalBands == 4)
                                ? ResistorBandGestureDetctr(
                                    selected1: selected1,
                                    selected2: selected2,
                                    selected3: selected3,
                                    bandColor: bandColor1,
                                    onTapR: () {
                                      setState(() {
                                        selected1 = !selected1;
                                        selected2 = selected3 =
                                            selected4 = selected5 = false;
                                      });
                                      print('selected 1 is $selected1');
                                    },
                                  )
                                : null,
                            (totalBands == 4)
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected1 = !selected1;
                                        selected2 = false;
                                        selected3 = false;
                                      });

                                      print(selected1);
                                      print('selected1');
                                      // colorChange();
                                    },
                                    child: buildBandContainer(bandColor2),
                                  )
                                : null,
                            (totalBands == 4)
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected1 = !selected1;
                                        selected2 = false;
                                        selected3 = false;
                                      });

                                      print(selected1);
                                      print('selected1');
                                      // colorChange();
                                    },
                                    child:buildBandContainer(bandColor3)
                                  )
                                : SizedBox.shrink(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected1 = !selected1;
                                  selected2 = false;
                                  selected3 = false;
                                });

                                print(selected1);
                                print('selected1');
                                // colorChange();
                              },
                              child:buildBandContainer(bandColor4)
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected2 = !selected2;
                                  selected1 = false;
                                  selected3 = false;
                                });
                                print('selected2');
                                print(selected2);

                                // colorChange();
                              },
                              child: buildBandContainer(bandColor5)
                            ),
                            SizedBox(
                              width:
                                  9, //the tolerance is further away from the other values
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected3 = !selected3;
                                  selected1 = false;
                                  selected2 = false;
                                });
                                print('selected3');
                                print(selected3);

                                // colorChange();
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
                  Container(
                    height: 10,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                  ),
                ],
              ),
            ),
            CircleColorPicker(
              strokeWidth: 5,
              onChanged: (Color color) {
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
                }
              },
              textStyle: TextStyle(
                color: bandColor1,
                fontSize: 30.0,
              ),
              colorCodeBuilder: (context, color) {
                var _controller = TextEditingController();

                return Dialog(
                  elevation: 3.0,
                  backgroundColor: Colors.blueGrey,
                  insetPadding: EdgeInsets.symmetric(horizontal: 65),
                  child: TextField(
                    controller: _controller,
                    cursorHeight: 26,
                    cursorColor: color,
                    textAlign: TextAlign.center,
                    autocorrect: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: convert.hex
                          .keyword(color.value.toRadixString(16))
                          .toString(),
                    ),
                    onSubmitted: (colorNameTyped) {
                      //using the color converter library/dependency to get the name of the color
                      //convert its value to hex first

                      List colorRGBValue() {
                        try {
                          return convert.keyword
                              .rgb(colorNameTyped.toLowerCase());
                        } catch (error) {
                          print(error);
                        }
                      }

                      var colorName = colorRGBValue();
                      //convert it to the accepted ARGB format for colors
                      Color bandcolorSelected = Color.fromARGB(
                          255, colorName[0], colorName[1], colorName[2]);

                      //chandge the color of the selcted band according to the color input
                      if (selected1 == true) {
                        setState(() {
                          bandColor1 = bandcolorSelected;
                          _controller.clear(); //clears the textfield
                        });
                      } else if (selected2 == true) {
                        setState(() {
                          bandColor2 = bandcolorSelected;
                          _controller.clear();
                        });
                      } else if (selected3 == true) {
                        setState(() {
                          bandColor3 = bandcolorSelected;
                          _controller.clear();
                        });
                      } else {
                        print('Select a band');
                        _controller.clear();
                      }
                    },
                  ),
                );
              },
            ),
            FlatButton(
                onPressed: () {
                  print(testBandColor1.value);

                  print('<<<<<<>>>>>>');

                  matchColorToResistorValue(bandColor1);
                },
                child: Text('press me'))
          ],
        ),
      ),
    );
  }

  Container buildBandContainer(Color bandColor) {
    return Container(
      color: bandColor,
      width: 10,
    );
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

// class ClockPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     var centerX = size.width / 2;
//     var centery = size.height / 2;
//     var center = Offset(centerX, centery);
//     var radius = min(centerX, centery);

//     var fillBrush = Paint()..color = Colors.red;
//     var outlineBrush = Paint()
//       ..strokeWidth = 16
//       ..style = PaintingStyle.stroke
//       ..color = Colors.white;

//     var centerfillBrush = Paint()..color = Colors.white;

//     var secondHandBrush = Paint()
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 16
//       ..style = PaintingStyle.stroke
//       ..color = Colors.orange[300];

//     var minHandBrush = Paint()
//       ..shader = RadialGradient(colors: [Colors.lightBlue, Colors.pink])
//           .createShader(Rect.fromCircle(center: center, radius: radius))
//       ..strokeWidth = 16
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.stroke
//       ..color = Colors.orange[300];

//     var hourHandBrush = Paint()
//       ..shader = RadialGradient(colors: [Colors.lightBlue, Colors.pink])
//           .createShader(Rect.fromCircle(center: center, radius: radius))
//       ..strokeWidth = 16
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.stroke
//       ..color = Colors.orange[300];

//     canvas.drawCircle(center, radius - 20, fillBrush);
//     canvas.drawCircle(center, radius - 20, outlineBrush);
//     canvas.drawLine(center, Offset(100, 100), secondHandBrush);
//     canvas.drawLine(center, Offset(150, 100), minHandBrush);
//     canvas.drawLine(center, Offset(200, 150), hourHandBrush);
//     canvas.drawCircle(center, 14, centerfillBrush);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
