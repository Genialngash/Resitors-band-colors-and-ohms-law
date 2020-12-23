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

  Color bandColor4 = Colors.indigo;
  Color mutplrBandColor = Colors.brown;
  Color tlrncBandColor = Colors.yellow;

  Color colorPickerColor;
  Color certainColor;
  bool selected1 = false;
  bool selected2 = false;
  bool selected3 = false;

  void matchColorToResistorValue() {
    //  ff03040E
    if (bandColor1.value <= 4278387726) {
      print('black');
    } else {
      print('not black');
    }
  }

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
                            // ResistorBand(bandColor1),
                            // ResistorBand(bandColor2),
                            // ResistorBand(bandColor3),
                            // ResistorBand(bandColor4),
                            // ResistorBand(mutplrBandColor),
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
                              child: Container(
                                color: bandColor1,
                                width: 10,
                              ),
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
                              child: Container(
                                color: bandColor2,
                                width: 10,
                              ),
                            ),
                            SizedBox(
                              width:
                                  10, //the tolerance is further away from the other values
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
                              child: Container(
                                color: bandColor3,
                                width: 10,
                              ),
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
                  var colorNameHex =
                      convert.hex.keyword(bandColor3.value.toRadixString(16));
                  print(colorNameHex);
                  print('<<<<<<>>>>>>');
                  matchColorToResistorValue();
                  print(bandColor1.value.toRadixString(16));
                  print(bandColor2.value.toRadixString(16));
                  print(bandColor3.value);
                },
                child: Text('press me'))
          ],
        ),
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
