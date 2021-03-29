import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resistohms/constants.dart';
import 'package:resistohms/custom_icons/my_flutter_app_icons.dart';

class OhmsLawCalculator extends StatefulWidget {
  @override
  _OhmsLawCalculatorState createState() => _OhmsLawCalculatorState();
}

class _OhmsLawCalculatorState extends State<OhmsLawCalculator> {
  TextEditingController _voltageController = TextEditingController();
  TextEditingController _resistanceController = TextEditingController();
  TextEditingController _powerController = TextEditingController();
  TextEditingController _currentController = TextEditingController();

  List<DropdownMenuItem<int>> voltDownMenuItems = [
    DropdownMenuItem(
      child: Text('MegaVolts'),
      value: 1000000,
    ),
    DropdownMenuItem(
      child: Text('KiloVolts'),
      value: 1000,
    ),
    DropdownMenuItem(
      child: Text('volts'),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text('milliVolts'),
      value: 99,
    ),
  ];

  int voltsMultiplier = 1;
  var voltage;
  var current;
  var resistance;
  var power;
  var inputVoltage;
  String resistanceHintText = 'resistance';
  String powerHintText = 'power';

  @override
  Widget build(BuildContext context) {
    bool voltageFieldIsEmpty = _voltageController.text.isEmpty;
    bool currentFieldIsEmpty = _currentController.text.isEmpty;
    bool resistanceFieldIsEmpty = _resistanceController.text.isEmpty;
    bool powerFieldIsEmpty = _powerController.text.isEmpty;

    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: TextField(
                cursorWidth: 3.5,
                keyboardType: TextInputType.numberWithOptions(),
                controller: _voltageController,
                maxLength: 14,
                cursorColor: Color(0xff98DEDA),
                style: textStyling(fontSize: 30),
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'voltage',
                  counter: Offstage(),
                ),
                onChanged: (String input) {
                  print(voltage);
                  setState(() {
                    inputVoltage = double.tryParse(input);
                  });
                },
                // onEditingComplete: () {
                //   _voltageController.clear();
                // },
              ),
              trailing: DropdownButton(
                dropdownColor: Color(0xffC0C3DC),
                items: voltDownMenuItems,
                underline: Offstage(),
                onChanged: (int value) {
                  if (value == 99) {
                    setState(() {
                      voltsMultiplier =
                          value; // change the value to its respective name of the prefix
                    });
                    voltage = inputVoltage * 0.001;
                  } else {
                    setState(() {
                      voltsMultiplier =
                          value; // change the value to its respective name of the prefix
                    });
                    voltage = inputVoltage * value;
                  }
                  print(voltage);
                },
                value: voltsMultiplier,
              ),
            ),
            ListTile(
              title: TextField(
                cursorWidth: 4.0,
                keyboardType: TextInputType.numberWithOptions(),
                controller: _currentController,
                maxLength: 14,
                cursorColor: Color(0xff98DEDA),
                style: textStyling(fontSize: 30),
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'current',
                  counter: Offstage(),
                ),
                onChanged: (String input) {
                  setState(() {
                    current = double.tryParse(input);
                  });
                },
                // onEditingComplete: () {
                //   _voltageController.clear();
                // },
              ),
              trailing:
                  DropdownButton(items: voltDownMenuItems, onChanged: null),
            ),
            ListTile(
              title: TextField(
                cursorWidth: 4.0,
                keyboardType: TextInputType.numberWithOptions(),
                controller: _resistanceController,
                maxLength: 14,
                cursorColor: Color(0xff98DEDA),
                style: textStyling(fontSize: 30),
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: resistanceHintText,
                  counter: Offstage(),
                ),
                onChanged: (String input) {
                  setState(() {
                    resistance = double.tryParse(input);
                  });
                },
                // onEditingComplete: () {
                //   _voltageController.clear();
                // },
              ),
              trailing:
                  DropdownButton(items: voltDownMenuItems, onChanged: null),
            ),
            ListTile(
              title: TextField(
                cursorWidth: 4.0,
                keyboardType: TextInputType.numberWithOptions(),
                controller: _powerController,
                maxLength: 14,
                cursorColor: Color(0xff98DEDA),
                style: textStyling(fontSize: 30),
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: powerHintText,
                  counter: Offstage(),
                ),
                onChanged: (String input) {
                  setState(() {
                    power = double.tryParse(input);
                  });
                },
                // onEditingComplete: () {
                //   _voltageController.clear();
                // },
              ),
              trailing:
                  DropdownButton(items: voltDownMenuItems, onChanged: null),
            ),
            RaisedButton(onPressed: () {
              try {
                //check if the current field is empty first
                if (currentFieldIsEmpty) {
                  if (powerFieldIsEmpty) {
                    //calculate current from voltage and resistance only if power field is empty
                    _currentController.text = (voltage / resistance).toString();
                  } else if (resistanceFieldIsEmpty) {
                    //calculate current from power and  voltage only
                    _currentController.text = (power / voltage).toString();
                  } else if (voltageFieldIsEmpty) {
                    //calculate current from power and resistance only
                    _currentController.text =
                        (sqrt(power / resistance)).toString();
                  } else {
                    buildSnackbar(context, '  INPUT TWO FIELDS ');
                  }
                } else if (voltageFieldIsEmpty) {
                  if (powerFieldIsEmpty) {
                    _voltageController.text = (current * resistance).toString();
                  } else if (resistanceFieldIsEmpty) {
                    _voltageController.text = (power / current).toString();
                  } else if (currentFieldIsEmpty) {
                    _voltageController.text =
                        (sqrt(power / resistance)).toString();
                  } else {
                    buildSnackbar(context, '  INPUT TWO FIELDS ');
                  }
                } else if (resistanceFieldIsEmpty) {
                  if (voltageFieldIsEmpty) {
                    _resistanceController.text =
                        (power / (current * current)).toString();
                  } else if (currentFieldIsEmpty) {
                    _resistanceController.text =
                        ((pow(voltage, 2)) / power).toString();
                  } else if (powerFieldIsEmpty) {
                    _resistanceController.text = (voltage / current).toString();
                  } else {
                    buildSnackbar(context, '  INPUT TWO FIELDS ');
                  }
                } else if (powerFieldIsEmpty) {
                  if (currentFieldIsEmpty) {
                    _powerController.text =
                        ((pow(voltage, 2)) / resistance).toString();
                  } else if (voltageFieldIsEmpty) {
                    _powerController.text =
                        ((pow(current, 2)) * resistance).toString();
                  } else if (resistanceFieldIsEmpty) {
                    _powerController.text = (voltage * current).toString();
                  } else {
                    buildSnackbar(context, '  INPUT TWO FIELDS ');
                  }
                } else {
                  buildSnackbar(context, '  INVALID INPUT / INPUTS ');
                }
              } catch (e) {
                buildSnackbar(context, '  INVALID INPUT / INPUTS ');
              }
            })
          ],
        ),
      ),
    );
  }
}

class OhmsListTile extends StatelessWidget {
  const OhmsListTile({
    @required TextEditingController controller,
    @required this.dropDownMenuItems,
  }) : _controll = controller;

  final TextEditingController _controll;
  final List<DropdownMenuItem<int>> dropDownMenuItems;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextField(
        cursorWidth: 3.5,
        keyboardType: TextInputType.numberWithOptions(),
        controller: _controll,
        maxLength: 14,
        cursorColor: Color(0xff98DEDA),
        style: textStyling(fontSize: 30),
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'current',
          counter: Offstage(),
        ),
        onChanged: (String input) {
          input = input.toUpperCase();
          print(input);
        },
        // onEditingComplete: () {
        //   _controll.clear();
        // },
      ),
      trailing: DropdownButton(items: dropDownMenuItems, onChanged: null),
    );
  }
}
