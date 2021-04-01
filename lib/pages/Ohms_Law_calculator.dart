import 'dart:math';
import 'dart:wasm';

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

  List<DropdownMenuItem<num>> voltDownMenuItems = [
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
      value: 0.01,
    ),
  ];

  List<DropdownMenuItem<num>> currentDownMenuItems = [
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
      value: 0.01,
    ),
  ];

  List<DropdownMenuItem<num>> resistanceDownMenuItems = [
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
      child: Text('milliOhms'),
      value: 0.01,
    ),
  ];

  List<DropdownMenuItem<num>> powerDownMenuItems = [
    DropdownMenuItem(
      child: Text('MegaWatts'),
      value: 1000000,
    ),
    DropdownMenuItem(
      child: Text('KiloWatts'),
      value: 1000,
    ),
    DropdownMenuItem(
      child: Text('Watts'),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text('milliWatts'),
      value: 0.01,
    ),
  ];

  num voltsMultiplier = 1;
  num currentMultiplier = 1;
  num resistanceMultiplier = 1;
  num powerMultiplier = 1;

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
                maxLines: null,
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
                onChanged: (num value) {
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
                maxLines: null,
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
                  onChanged: (num value) {
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
                maxLines: null,
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
                },
                // onEditingComplete: () {
                //   _voltageController.clear();
                // },
              ),
              trailing: DropdownButton(
                  items: resistanceDownMenuItems,
                  value: resistanceMultiplier,
                  underline: Offstage(),
                  onChanged: (num value) {
                    setState(() {
                      resistanceMultiplier = value;
                    });
                  }),
            ),
            ListTile(
              title: TextField(
                cursorWidth: 4.0,
                keyboardType: TextInputType.numberWithOptions(),
                controller: _powerController,
                maxLength: 14,
                maxLines: null,
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
                    powerInput = input;
                  });
                },
              ),
              trailing: DropdownButton(
                  underline: Offstage(),
                  value: powerMultiplier,
                  items: powerDownMenuItems,
                  onChanged: (num value) {
                    setState(() {
                      powerMultiplier = value;
                    });
                  }),
            ),
            RaisedButton(
                child: Text('Calculate'),
                onPressed: () {
                try{

                    if (voltageFieldIsEmpty == false) {
                    voltage = double.tryParse(voltageInput) * voltsMultiplier;
                  } else {
                    voltage = null;
                  }
                  print(voltage);
                  if (currentFieldIsEmpty == false) {
                    current = double.tryParse(currentInput) * currentMultiplier;
                  } else {
                    current = null;
                  }
                  print(current);
                  if (resistanceFieldIsEmpty == false) {
                    print(resistanceMultiplier);
                    print(resistanceInput);
                    resistance =
                        double.tryParse(resistanceInput) * resistanceMultiplier;
                  } else {
                    resistance = null;
                  }
                  print(resistance);
                  if (powerFieldIsEmpty == false) {
                    power = double.tryParse(powerInput) * powerMultiplier;
                  } else {
                    power = null;
                  }
                    // Two fields should be empty ,this is to avoid the user from inputting unmatching values
                    //check if the current field is empty first
                    if (currentFieldIsEmpty) {
                      if (powerFieldIsEmpty) {
                        //calculate current from voltage and resistance
                        //calculate power from voltage and resistance
                        currentInput = (voltage / resistance).toString();
                        powerInput =
                            ((pow(voltage, 2)) / resistance).toString();
                      } else if (resistanceFieldIsEmpty) {
                        //calculate current and resistance
                        currentInput = (power / voltage).toString();
                        resistanceInput =
                            ((pow(voltage, 2)) / power).toString();
                      } else if (voltageFieldIsEmpty) {
                        //calculate current and voltage
                        currentInput = (sqrt(power / resistance)).toString();

                        voltageInput = (sqrt(power / resistance)).toString();
                      } else {
                        buildSnackbar(context, '  Enter any two known values ');
                      }
                    } else if (voltageFieldIsEmpty) {
                      if (powerFieldIsEmpty) {
                        voltageInput = (current * resistance).toString();
                        powerInput =
                            ((pow(current, 2)) * resistance).toString();
                        print(powerInput);
                        print('>>>>>>>>>>>>>>');
                      } else if (resistanceFieldIsEmpty) {
                        voltageInput = (power / current).toString();
                        resistanceInput =
                            (power / (current * current)).toString();
                      } else if (currentFieldIsEmpty) {
                        print('current empty');
                        voltageInput = (sqrt(power / resistance)).toString();
                        currentInput = (sqrt(power / resistance)).toString();
                      } else {
                        buildSnackbar(
                            context, '  Enter any two known values  ');
                      }
                    } else if (resistanceFieldIsEmpty) {
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
                        buildSnackbar(
                            context, '  Enter any two known values  ');
                      }
                    } else if (powerFieldIsEmpty) {
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
                        buildSnackbar(context, '  Enter any two known values ');
                      }
                    } else {
                      buildSnackbar(context, '  INVALID INPUT / INPUTS ');
                    }
                    //formatting the answer to mega , kilo or the standard way
                    // change the dropdown to the respective measuring standard by calling setState
                    var volts = double.tryParse(voltageInput) * voltsMultiplier;
                    var amps =
                        double.tryParse(currentInput) * currentMultiplier;
                    var ohms =
                        double.tryParse(resistanceInput) * resistanceMultiplier;
                    var watts = double.tryParse(powerInput) * powerMultiplier;

                    if (volts > 1000000) {
                      setState(() {
                        voltsMultiplier = 1000000;
                      });
                      voltageInput = (volts / 1000000).toStringAsFixed(4);
                    } else if (volts > 1000) {
                      setState(() {
                        voltsMultiplier = 1000;
                      });
                      voltageInput = (volts / 1000).toStringAsFixed(4);
                    } else {
                      setState(() {
                        voltsMultiplier = 1;
                      });
                      voltageInput = volts.toStringAsFixed(4);
                    }
                    if (amps > 1000000) {
                      setState(() {
                        currentMultiplier = 1000000;
                      });
                      currentInput = (amps / 1000000).toStringAsFixed(4);
                    } else if (amps > 1000) {
                      setState(() {
                        currentMultiplier = 1000;
                      });
                      currentInput = (amps / 1000).toStringAsFixed(4);
                    } else {
                      setState(() {
                        currentMultiplier = 1;
                      });
                      currentInput = amps.toStringAsFixed(4);
                       
                    }
                    if (ohms > 1000000) {
                      setState(() {
                        resistanceMultiplier = 1000000;
                      });
                      resistanceInput = (ohms / 1000000).toStringAsFixed(4);
                    } else if (ohms > 1000) {
                      setState(() {
                        resistanceMultiplier = 1000;
                      });
                      resistanceInput = (ohms / 1000).toStringAsFixed(4);
                    } else {
                      setState(() {
                        resistanceMultiplier = 1;
                      });
                      resistanceInput = ohms.toStringAsFixed(4);
                    }

                    if (watts > 1000000) {
                      setState(() {
                        powerMultiplier = 1000000;
                      });
                      powerInput = (watts / 1000000).toStringAsFixed(4);
                    } else if (watts > 1000) {
                      setState(() {
                        powerMultiplier = 1000;
                      });
                      powerInput = (watts / 1000).toStringAsFixed(4);
                    } else {
                      setState(() {
                        powerMultiplier = 1;
                      });
                      powerInput = watts.toStringAsFixed(4);
                     
                    }

                    _voltageController.text = voltageInput;
                    _currentController.text = currentInput;
                    _resistanceController.text = resistanceInput;
                    _powerController.text = powerInput;
                  } catch (e) {
                  
                    buildSnackbar(context, '  INVALID VALUES ');
                  }
                })
          ],
        ),
      ),
    );
  }
}
