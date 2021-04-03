import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:resistohms/color_picker.dart';

import 'package:resistohms/helper/sharedPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'package:color_convert/color_convert.dart';

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
  var finalAnswer = '462.0 ohms +/-1% Tolerance';
  var answer;

  //check the settings of the color picker in shared preferences
  // Load the settings on init state
  bool showCircularColorPicker= false ;

  bool showLinearcolorPicker= true;

  bool selected1 = false;
  bool selected2 = false;
  bool selected3 = false;
  bool selected4 = false;
  bool selected5 = false;
  bool selected6 = false;

  TextEditingController _controller = TextEditingController();
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
    // calculateFinalAnswer();

    //set the settings from shared preferences
    // show the color picker needed from the settings
   getColoPickerSetttings();

    print(showCircularColorPicker);
    print(showLinearcolorPicker);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> getColoPickerSetttings() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    bool circularColorPicker = preferences.getBool('circular') ?? false;
    bool linearcolorPicker = preferences.getBool('linear') ?? true
    setState(() {
      showLinearcolorPicker = linearcolorPicker;
    });
    setState(() {
      showCircularColorPicker = circularColorPicker;
    });
  }

// VALUE[0]  MULTIPLIER[1] TOLERANCE[2] TEMPERATURE CO-EFFICIENT[3]
// 99 shows that the value of the color is not available in the band color chart.
  List black = ['0', '1', '+/- 0%', '250 ppm/K', 'NULL'];
  List brown = ['1', '10', '+/-1%', '100 ppm/K', '1%'];
  List red = ['2', '100', '+/-2%', '50 ppm/K', '0.1%'];
  List orange = ['3', '1000', '+/-0%', '15 ppm/K', '0.01%'];
  List yellow = ['4', '10000', '+/-0%', '25 ppm/K', '0.001%'];
  List green = ['5', '100000', '+/-0.5%', '20 ppm/K', 'NULL'];
  List blue = ['6', '1000000', '+/-0.25%', '10 ppm/K', 'NULL'];
  List violet = ['7', '10000000', '+/-0.1%', '5 ppm/K', 'NULL'];
  List grey = ['8', '100000000', '+/-0.05%', '1 ppm/K', 'NULL'];
  List white = ['9', '1000000000', '+/-0%', 'NULL', 'NULL'];
  List gold = ['99', '0.1', '+/-5%', 'NULL', 'NULL'];
  List silver = ['99', '0.01', '+/10%', 'NULL'];
  //if the user inputs unavailable color
  List noValue = ['99', '99', 'NULL', 'NULL', 'NULL'];

  List matchColorToResistorValue(Color bandColor) {
    var converted =
        convert.hex.keyword(bandColor.value.toRadixString(16)).toString();

    if (converted == 'red' || converted == 'firebrick') {
      print('red');
      return red;
    } else if (converted == 'mediumblue' ||
        converted == 'midnightblue' ||
        converted == 'blue' ||
        converted == 'royalblue' ||
        converted == 'darkblue') {
      print('blue');
      return blue;
    } else if (converted == 'green' ||
            converted == 'olivedrab' ||
            converted == 'forestgreen' ||
            converted == 'darkgreen'
        // converted == 'darkslategray'
        ) {
      print('green');
      return green;
    } else if (converted == 'brown' || converted == 'sienna') {
      print('brown');
      return brown;
    } else if (converted == 'dimgray' ||
        converted == 'darkgray' ||
        converted == 'gray') {
      print('grey');
      return grey;
    } else if (converted == 'mediumorchid' ||
        converted == 'orchid' ||
        converted == 'violet') {
      print('violet');
      return violet;
    } else if (converted == 'silver') {
      print('silver');
      return silver;
    } else if (converted == 'darkorange' || converted == 'orange') {
      print('orange');
      return orange;
    } else if (converted == 'gold') {
      print('gold');
      return gold;
    } else if (converted == 'yellow' || converted == 'greenyellow') {
      print('yellow');
      return yellow;
    } else if (converted == 'snow' ||
        converted == 'white' ||
        converted == 'whitesmoke') {
      print('white');
      return white;
    } else if (converted == 'black' || converted == 'darkslategray') {
      print('black');
      return black;
    } else {
      return noValue;
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
        buildSnackbar(context, 'Wrong color name');
        _controller.clear();
      }
    }

    return Container(
      alignment: Alignment.center,
      // decoration: BoxDecoration(
      //           gradient: RadialGradient(
      //         tileMode: TileMode.clamp,
      //         colors: [
      //           //Color(0xff192323),
      //           //Color(0xff213F21),
      //           Color(0xff114111),
      //           Color(0xff305A3F),
      //           Color(0xff305A3F),
      //           // Color(0xff062424),

      //           // Color(0xff4D4D55),
      //         ],
      //       )),
      child: Scrollbar(
        //isAlwaysShown: true,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Switch(
                        value: showLinearcolorPicker,
                        onChanged: (bool value) async {
                          setState(() {
                            showLinearcolorPicker = value;
                          });
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.setBool('linear', value);
                        }),
                    Switch(
                        value: showCircularColorPicker,
                        onChanged: (bool value) async {
                          setState(() {
                            showCircularColorPicker = value;
                          });
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.setBool('circular', value);
                        }),
                  ],
                ),
                androidDropdown(
                  totalBands: totalBands,
                  onChange: (int newValue) {
                    setState(() {
                      totalBands = newValue;
                    });
                    calculateFinalAnswer();
                  },
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                          ),
                        ],
                      ),
                      kresistorEndWire(1),
                    ],
                  ),
                ),
                //check the settings if the colorPicker should be shown first
                showLinearcolorPicker == true
                    ? ColorPicker(
                        width: screenWidth - 40,
                        onColorChanged: (Color color) async {
                          await bandColorChange(color);
                          calculateFinalAnswer();
                        },
                        onSubmitColorName: (colorNameTyped) {
                          changeBandColorFromTextFieldInput(
                              colorNameTyped, context);
                          calculateFinalAnswer();
                        },
                      )
                    : Offstage(),
                //check if the color picker should be shown from shared preference
                showCircularColorPicker == true
                    ? CircleColorPicker(
                        strokeWidth: 5,
                        onChanged: (Color color) {
                          bandColorChange(color);
                          calculateFinalAnswer();
                        },
                        colorCodeBuilder: (contex, color) {
                          return buildDialog(
                              controller: _controller,
                              color: color,
                              onSubmit: (colorNameTyped) {
                                changeBandColorFromTextFieldInput(
                                    colorNameTyped, context);
                                calculateFinalAnswer();
                              });
                        })
                    : Offstage(),
                Text(
                  finalAnswer.toString(),
                  style: textStyling(fontSize: 24),
                ),
                Text(finalAnswer.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateFinalAnswer() {
    print('<<<<<<>>>>>>');

    var band1 = matchColorToResistorValue(bandColor1);
    var band2 = matchColorToResistorValue(bandColor2);
    var band3 = matchColorToResistorValue(bandColor3);
    var band4 = matchColorToResistorValue(bandColor4);
    var band5 = matchColorToResistorValue(bandColor5);
    var band6 = matchColorToResistorValue(bandColor6);

    if (totalBands == 3) {
      String defaultTolerance3Band = '+/- 20% Tolerance';
      //change the first elements from string to int (casting)
      var first2Bands = int.tryParse(band1[0] + band4[0]);

      //multiply the first3Bands with the value of the resistor multiplier
      var answe = (first2Bands * (double.tryParse(band6[1])));

      //check if the user has selected incorrect color
      if (first2Bands > 100 || band4[1] == '99') {
        print('there is problem with the bands selected');
        answer = 'Please check the color selected';
      }

      //add the tolerance
      else if (answe > 100000) {
        answe = answe / 100000;
        answer = answe.toString() + ' MegaOhms  ' + defaultTolerance3Band;

        print(answe);
        print(answer);
      } else if (answe > 1000) {
        answe = answe / 1000;
        answer = answe.toString() + ' KiloOhms  ' + defaultTolerance3Band;
        print(answer);
      } else {
        answer = answe.toString() + ' ohms  ' + defaultTolerance3Band;
        print(answer);
      }
      setState(() {
        finalAnswer = answer;
      });
      return answer;
    } else if (totalBands == 4) {
      //change the first elements from string to int (casting)
      var first2Bands = int.tryParse(band1[0] + band3[0]);
      //multiply the first3Bands with the value of the resistor multiplier

      var answe = (first2Bands * (double.tryParse(band4[1])));
      //check if the user has selected incorrect color
      if (first2Bands > 1000 || band4[1] == '99') {
        print('there is problem with the bands selected');
        answer = 'Please check the color selected';
      }
      //add the tolerance
      else if (answe > 100000) {
        answe = answe / 100000;
        answer = answe.toString() + ' MegaOhms  ' + band6[2] + ' Tolerance ';

        print(answe);
        print(answer);
      } else if (answe > 1000) {
        answe = answe / 1000;
        answer = answe.toString() + ' KiloOhms  ' + band6[2] + ' Tolerance ';
        print(answer);
      } else {
        answer = answe.toString() + ' ohms  ' + band6[2] + ' Tolerance ';

        print(answer);
      }
      setState(() {
        finalAnswer = answer;
      });
      return answer;
    } else if (totalBands == 5) {
      //change the first elements from string to int (casting)
      var first3Bands = int.tryParse(band1[0] + band2[0] + band3[0]);
      //multiply the first3Bands with the value of the resistor multiplier

      var answe = (first3Bands * (double.tryParse(band4[1])));

      //check if the user has selected incorrect color
      if (first3Bands > 1000 || band4[1] == '99') {
        print('there is problem with the bands selected');
        answer = 'Please check the color selected';
      }

      //add the tolerance
      else if (answe > 100000) {
        answe = answe / 100000;
        answer = answe.toString() + ' MegaOhms  ' + band6[2] + ' Tolerance ';

        print(answe);
        print(answer);
      } else if (answe > 1000) {
        answe = answe / 1000;
        answer = answe.toString() + ' KiloOhms  ' + band6[2] + ' Tolerance ';
        print(answer);
      } else {
        answer = answe.toString() + ' ohms  ' + band6[2] + ' Tolerance ';

        print(answer);
      }
      print('++++++++++++++++++++');
      setState(() {
        finalAnswer = answer;
      });
      return answer;
    } else if (totalBands == 6) {
      //change the first elements from string to int (casting)
      var first3bands = int.tryParse(band1[0] + band2[0] + band3[0]);
      //multiply the fig with the value of the resistor multiplier
      var answe = (first3bands * (double.tryParse(band4[1])));

      //check if the user has selected incorrect color
      if (first3bands > 1000 || band4[1] == '99') {
        print('there is problem with the bands selected');
        answer = 'Please check the color selected';
      }
      // add the tolerance and temperature co-efficient
      else if (answe > 1000000000) {
        answe = answe / 1000000000;
        answer = answe.toString() +
            ' GigaOhms  ' +
            band5[2] +
            ' Tolerance ' +
            band6[3] +
            ' Temp co-eff';
        print(answe);
        print(answer);
      } else if (answe > 1000000) {
        answe = answe / 1000000;
        answer = answe.toString() +
            ' MegaOhms  ' +
            band5[2] +
            ' Tolerance ' +
            band6[3] +
            ' Temp co-eff';
        print(answe);
        print(answer);
        return answer;
      } else if (answe > 1000) {
        answe = answe / 1000;
        answer = answe.toString() +
            ' KiloOhms  ' +
            band5[2] +
            ' Tolerance ' +
            band6[3] +
            ' Temp co-eff';
        print(answer);
        return answer;
      } else {
        answer = answe.toString() +
            ' ohms  ' +
            band5[2] +
            ' Tolerance ' +
            band6[3] +
            ' Temp co-eff';

        print(answer);
      }

      print(first3bands);
      print(answe);
      print('++++++++++++++++++++');
      setState(() {
        finalAnswer = answer;
      });
      return answer;
    }
    setState(() {
      finalAnswer = answer;
    });
  }
}
