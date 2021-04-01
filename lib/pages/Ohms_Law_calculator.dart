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

  List<DropdownMenuItem<int>> currentDownMenuItems = [
    DropdownMenuItem(
      child: Text('MegaAmps'),
      value: 1000000,
    ),
    DropdownMenuItem(
      child: Text('KiloAmps'),
      value: 1000,
    ),
    DropdownMenuItem(
      child: Text('Amps'),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text('milliAmps'),
      value: 99,
    ),
  ];

  List<DropdownMenuItem<int>> resistanceDownMenuItems = [
    DropdownMenuItem(
      child: Text('MegaOhms'),
      value: 1000000,
    ),
    DropdownMenuItem(
      child: Text('KiloOhms'),
      value: 1000,
    ),
    DropdownMenuItem(
      child: Text('ohms'),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text('millOhms'),
      value: 99,
    ),
  ];

  int voltsMultiplier = 1;
  int currentMultiplier = 1;
  int resistanceMultiplier = 1;
  int powerMultiplier = 1;

  bool powerSelected = false;
  var voltage;
  var current;
  var resistance;
  var power;

  var voltageInput;
  var currentInput;
  var resistanceInput;
  var powerInput;

  var inputVoltage;
  String resistanceHintText = 'resistance';
  String powerHintText = 'power';
  String currentHintText = 'current';
  String voltageHintText = 'voltage';

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
                  hintText: voltageHintText,
                  counter: Offstage(),
                ),
                onChanged: (String input) {
                  print(voltage);
                  setState(() {
                    voltageInput = input;
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
                  setState(() {
                    voltsMultiplier =
                        value; // change the value to its respective name of the prefix
                  });

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
                  hintText: currentHintText,
                  counter: Offstage(),
                ),
                onChanged: (String input) {
                  setState(() {
                    // _currentController.text = input;
                    currentInput = input;
                  });
                },
                // onEditingComplete: () {
                //   _voltageController.clear();
                // },
              ),
              trailing: DropdownButton(
                  items: currentDownMenuItems,
                  value: currentMultiplier,
                  underline: Offstage(),
                  onChanged: (int value) {
                    setState(() {
                      currentMultiplier = value;
                    });

                    print(current);
                  }),
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
                    //  _resistanceController.text = input;
                    resistanceInput = input;
                  });
                  input = _resistanceController.text;
                  print("============");
                  print(input);
                  print("============");
                },
                // onEditingComplete: () {
                //   _voltageController.clear();
                // },
              ),
              trailing: DropdownButton(
                  items: resistanceDownMenuItems,
                  value: resistanceMultiplier,
                  underline: Offstage(),
                  onChanged: (int value) {
                    setState(() {
                      resistanceMultiplier = value;
                    });
                  }),
            ),
            ListTile(
              subtitle: Checkbox(
                  // tristate: true,
                  value: powerSelected,
                  onChanged: (bool value) {
                    print(powerSelected);
                    setState(() {
                      powerSelected = value;
                    });
                  }),
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
                  hintMaxLines: 3,
                  counter: Offstage(),
                ),
                onChanged: (String input) {
                  setState(() {
                    powerInput = input;
                  });
                },
                onEditingComplete: () {
                  print('on editing com');
                },
              ),
              trailing: DropdownButton(
                  underline: Offstage(),
                  items: voltDownMenuItems,
                  onChanged: (int value) {
                    setState(() {
                      powerMultiplier = value;
                    });
                  }),
            ),
            RaisedButton(
                child: Text('data'),
                onPressed: () {
                  print(currentFieldIsEmpty);
                  print(resistanceFieldIsEmpty);

                  if (voltageFieldIsEmpty == false) {
                    voltage = voltsMultiplier == 99
                        ? double.tryParse(voltageInput) * 0.001
                        : double.tryParse(voltageInput) * voltsMultiplier;
                  } else {
                    voltage = null;
                  }
                  print(voltage);
                  if (currentFieldIsEmpty == false) {
                    current = currentMultiplier == 99
                        ? double.tryParse(currentInput) * 0.001
                        : double.tryParse(currentInput) * currentMultiplier;
                  } else {
                    current = null;
                  }
                  print(current);
                  if (resistanceFieldIsEmpty == false) {
                    resistance = resistanceMultiplier == 99
                        ? double.tryParse(resistanceInput) * 0.001
                        : double.tryParse(resistanceInput) *
                            resistanceMultiplier;
                  } else {
                    resistance = null;
                  }
                  print(resistance);
                  print(powerFieldIsEmpty);
                  print(_powerController.text);
                  print(powerInput);
                  if (powerFieldIsEmpty == false) {
                    power = powerMultiplier == 99
                        ? double.tryParse(powerInput) * 0.01
                        : double.tryParse(powerInput) * powerMultiplier;
                  } else {
                    power = null;
                  }
                  print(power);
                  print('+++++++++++++');
                  print(voltageInput);
                  print(resistanceInput);
                  print(currentInput);
                  print(powerInput);
                  print('+++++++++++++');


                  print(voltage);
                  print(current);
                  print(resistance);
                  print(power);

                  try {
                    print(voltage);
                    print(current);
                    print(resistance);
                    //check if the current field is empty first
                    if (currentFieldIsEmpty) {
                     
                      if (powerFieldIsEmpty) {
                        //calculate current from voltage and resistance 
                        //cal
                        currentInput = (voltage / resistance).toString();
                        powerInput =
                            ((pow(voltage, 2)) / resistance).toString();
                      } else if (resistanceFieldIsEmpty) {
                        //calculate current from power and  voltage only
                        currentInput = (power / voltage).toString();
                        resistanceInput =
                            ((pow(voltage, 2)) / power).toString();
                      } else if (voltageFieldIsEmpty) {
                        //calculate current from power and resistance only
                        currentInput = (sqrt(power / resistance)).toString();
                        voltageInput = (current * resistance).toString();
                      } else {
                        buildSnackbar(context, '  INPUT TWO FIELDS ');
                      }
                    } else if (voltageFieldIsEmpty) {
                      voltageInput = (current * resistance).toString();
                      if (powerFieldIsEmpty) {
                        voltageInput = (current * resistance).toString();
                        powerInput =
                            ((pow(current, 2)) * resistance).toString();
                      } else if (resistanceFieldIsEmpty) {
                        voltageInput = (power / current).toString();
                        resistanceInput =
                            (power / (current * current)).toString();
                      } else if (currentFieldIsEmpty) {
                        voltageInput = (sqrt(power / resistance)).toString();
                        currentInput = (sqrt(power / resistance)).toString();
                      } else {
                        buildSnackbar(context, '  INPUT TWO FIELDS ');
                      }
                    } else if (resistanceFieldIsEmpty) {
                      resistanceInput =
                          (power / (current * current)).toString();
                      if (voltageFieldIsEmpty) {
                        resistanceInput =
                            (power / (current * current)).toString();
                        voltageInput = (power / current).toString();
                      } else if (currentFieldIsEmpty) {
                        resistanceInput =
                            ((pow(voltage, 2)) / power).toString();
                        currentInput = _currentController.text =
                            (power / voltage).toString();
                      } else if (powerFieldIsEmpty) {
                        resistanceInput = (voltage / current).toString();
                        powerInput = (voltage * current).toString();
                      } else {
                        buildSnackbar(context, '  INPUT TWO FIELDS ');
                      }
                    } else if (powerFieldIsEmpty) {
                      powerInput = ((pow(voltage, 2)) / resistance).toString();
                      if (currentFieldIsEmpty) {
                        powerInput =
                            ((pow(voltage, 2)) / resistance).toString();

                        currentInput = _currentController.text =
                            (voltage / resistance).toString();
                      } else if (voltageFieldIsEmpty) {
                        powerInput =
                            ((pow(current, 2)) * resistance).toString();
                        voltageInput = (current * resistance).toString();
                      } else if (resistanceFieldIsEmpty) {
                        powerInput = (voltage * current).toString();
                        resistanceInput = (voltage / current).toString();
                      } else {
                        buildSnackbar(context, '  INPUT TWO FIELDS ');
                      }
                    } else {
                      buildSnackbar(context, '  INVALID INPUT / INPUTS ');
                    }

                    _voltageController.text = voltageInput;
                    _currentController.text = currentInput;
                    _resistanceController.text = resistanceInput;
                    _powerController.text = powerInput;
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
