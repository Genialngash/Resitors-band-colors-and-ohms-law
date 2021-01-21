import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:resistohms/color_picker.dart';
//import 'package:flutter_colorpicker/flutter_colorpicker.dart';
//import 'package:resistohms/cricin_colorPicker.dart';
import 'constants.dart';
import 'package:color_convert/color_convert.dart';

//import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';

class ColorCodeCalculator extends StatefulWidget {
  @override
  _ColorCodeCalculatorState createState() => _ColorCodeCalculatorState();
}

class _ColorCodeCalculatorState extends State<ColorCodeCalculator>
    with TickerProviderStateMixin {
  Color bandColor1 = Color.fromARGB(255, 255, 255, 0);
  Color bandColor2 = Color.fromARGB(255, 0, 0, 255);
  Color bandColor3 = Color.fromARGB(255, 255, 0, 0);
  Color bandColor4 = Color.fromARGB(255, 0, 0, 0);
  Color bandColor5 = Color.fromARGB(255, 0, 128, 0);
  Color bandColor6 = Color.fromARGB(255, 165, 42, 42);
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

  TextEditingController _controller = TextEditingController();

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

  AnimationController _animationController;
  Animation<double> _animation;
  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(
        milliseconds: 850,
      ),
      vsync: this,
      value: 0.1,
      lowerBound: 0.35,
      upperBound: 1,
    );
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutBack);
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void matchColorToResistorValue(Color bandColor) {
    var converted =
        convert.hex.keyword(bandColor.value.toRadixString(16)).toString();
  
    if (converted == 'red' || converted == 'firebrick') {
      print('red');
    } else if (converted == 'mediumblue' ||
        converted == 'midnightblue' ||
        converted == 'blue' ||
        converted == 'royalblue') {
      print('blue');
    } else if (converted == 'green' ||
        converted == 'olivedrab' ||
        converted == 'forestgreen' ||
        converted == 'darkgreen' ||
        converted == 'darkslategray') {
      print('green');
    } else if (converted == 'brown' || converted == 'sienna') {
      print('brown');
    } else if (converted == 'dimgray' ||
        converted == 'darkgray' ||
        converted == 'gray') {
      print('grey');
    } else if (converted == 'mediumorchid' ||
        converted == 'orchid' ||
        converted == 'violet') {
      print('violet');
    } else if (converted == 'silver') {
      print('silver');
    } else if (converted == 'darkorange' || converted == 'orange') {
      print('orange');
    } else if (converted == 'gold') {
      print('gold');
    } else if (converted == 'yellow' || converted == 'greenyellow') {
      print('yellow');
    } else if (converted == 'snow' ||
        converted == 'white' ||
        converted == 'whitesmoke') {
      print('white');
    } else if (converted == 'black' || converted == 'darkslategray') {
      print('black');
    }
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    void changeBandColorFromTextFieldInput(
        String colorNameTyped, BuildContext context) {
      //using the color converter library/dependency to get the name of the color
      //convert its value to hex first

      var converted = convert.keyword.rgb(colorNameTyped.toLowerCase());
      //check if the color exists in the list
      //if it doesnt exist the method returns null.
      if ((converted.toString()) != null.toString()) {
        _controller.clear(); //clears the textfield

        var colorName = converted;
        //convert it to the accepted ARGB format for colors
        Color bandcolorSelected =
            Color.fromARGB(255, colorName[0], colorName[1], colorName[2]);

        //  change the color of the selected band according to the color input
        bandColorChange(bandcolorSelected);
      } else {
        print('error');
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Wrong color name'),
          behavior: SnackBarBehavior.floating,
        ));
        _controller.clear();
      }
    }

    return Scrollbar(
      //isAlwaysShown: true,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
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
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      selected1 = true;
                                      selected2 = selected3 = selected4 =
                                          selected5 = selected6 = false;
                                    });

                                    print('selected 1 is $selected1');
                                  },
                                  //if the band is selected ,show an animation.
                                  child: selected1
                                      ? buildFadeTransition(
                                          bandColor1, _animation)
                                      : buildBandContainer(bandColor1)),

                              //check the n.o bands selected.
                              (totalBands == 6 || totalBands == 5)
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selected2 = true;
                                          selected1 = selected3 = selected4 =
                                              selected5 = selected6 = false;
                                        });

                                        print('selected 2 is $selected2');
                                      },
                                      child: selected2
                                          ? buildFadeTransition(
                                              bandColor2, _animation)
                                          : buildBandContainer(bandColor2),
                                    )
                                  : SizedBox.shrink(),
                              (totalBands == 4) ||
                                      (totalBands == 5) ||
                                      (totalBands == 6)
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selected3 = true;
                                          selected1 = selected2 = selected4 =
                                              selected5 = selected6 = false;
                                        });

                                        print('selected 3 is $selected3');
                                      },
                                      child: selected3
                                          ? buildFadeTransition(
                                              bandColor3, _animation)
                                          : buildBandContainer(bandColor3))
                                  : SizedBox.shrink(),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected4 = true;
                                      selected1 = selected2 = selected3 =
                                          selected5 = selected6 = false;
                                    });

                                    print('selected 4 is $selected4');
                                  },
                                  child: selected4
                                      ? buildFadeTransition(
                                          bandColor4, _animation)
                                      : buildBandContainer(bandColor4)),
                              (totalBands == 6)
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selected5 = true;
                                          selected1 = selected2 = selected3 =
                                              selected4 = selected6 = false;
                                        });

                                        print('selected 5 is $selected5');
                                      },
                                      child: selected5
                                          ? buildFadeTransition(
                                              bandColor5, _animation)
                                          : buildBandContainer(bandColor5))
                                  : SizedBox.shrink(),
                              SizedBox(
                                width:
                                    9, //the tolerance is further away from the other values
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected6 = true;
                                    selected1 = selected2 = selected3 =
                                        selected4 = selected5 = false;
                                  });
                                  print('selected 6 is $selected6');
                                },
                                child: selected6
                                    ? buildFadeTransition(
                                        bandColor6, _animation)
                                    : buildBandContainer(bandColor6),
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
              ColorPicker(
                width: screenWidth - 40,
                onColorChanged: (Color color) {
                  bandColorChange(color);
                },
                onSubmitColorName: (colorNameTyped) {
                  changeBandColorFromTextFieldInput(colorNameTyped, context);
                },
              ),
              CircleColorPicker(
                  strokeWidth: 5,
                  onChanged: bandColorChange,
                  colorCodeBuilder: (contex, color) {
                    return buildDialog(
                        controller: _controller,
                        color: color,
                        onSubmit: (colorNameTyped) {
                          changeBandColorFromTextFieldInput(
                              colorNameTyped, context);
                        });
                  }),
              FlatButton(
                  onPressed: () {
                    print('<<<<<<>>>>>>');

                    matchColorToResistorValue(bandColor1);

                    print('++++++++++++++++++++');
                    matchColorToResistorValue(bandColor2);

                    print('++++++++++++++++++++');
                    matchColorToResistorValue(bandColor3);

                    print('++++++++++++++++++++');
                    matchColorToResistorValue(bandColor4);

                    print('++++++++++++++++++++');
                    matchColorToResistorValue(bandColor5);

                    print('++++++++++++++++++++');
                    matchColorToResistorValue(bandColor6);

                    print('++++++++++++++++++++');
                  },
                  child: Text('calculate')),
            ],
          ),
        ),
      ),
    );
  }
}
