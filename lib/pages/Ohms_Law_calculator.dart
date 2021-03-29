import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resistohms/constants.dart';
import 'package:resistohms/custom_icons/my_flutter_app_icons.dart';

class OhmsLawCalculator extends StatefulWidget {
  @override
  _OhmsLawCalculatorState createState() => _OhmsLawCalculatorState();
}

class _OhmsLawCalculatorState extends State<OhmsLawCalculator> {
  TextEditingController _controller = TextEditingController();
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

  int voltsValue = 1;
  var voltage;
  var current;
  var resistance;
  var power;

  @override
  Widget build(BuildContext context) {
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
                controller: _controller,
                maxLength: 14,
                cursorColor: Color(0xff98DEDA),
                style: textStyling(fontSize: 30),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'voltage',
                  counter: Offstage(),
                ),
                onChanged: (String input) {
                  input = ;
                  
                  print(input);
                  setState(() {});
                },
                onEditingComplete: () {
                  _controller.clear();
                },
              ),
              trailing: DropdownButton(
                dropdownColor: Color(0xffC0C3DC),
                items: voltDownMenuItems,
                underline: Offstage(),
                onChanged: (int newValue) {
                  setState(() {
                    voltsValue = newValue;
                  });
                },
                value: voltsValue,
              ),
            ),
            OhmsListTile(
                controller: _controller, dropDownMenuItems: voltDownMenuItems),
            ListTile(
              title: TextField(
                cursorWidth: 4.0,
                controller: _controller,
                maxLength: 14,
                cursorColor: Color(0xff98DEDA),
                style: textStyling(fontSize: 30),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'resistance',
                  counter: Offstage(),
                ),
                onChanged: (String input) {
                  input = input.toUpperCase();
                  print(input);
                  setState(() {});
                },
                onEditingComplete: () {
                  _controller.clear();
                },
              ),
              trailing:
                  DropdownButton(items: voltDownMenuItems, onChanged: null),
            ),
            ListTile(
              title: TextField(
                cursorWidth: 4.0,
                controller: _controller,
                maxLength: 14,
                cursorColor: Color(0xff98DEDA),
                style: textStyling(fontSize: 30),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'power',
                  counter: Offstage(),
                ),
                onChanged: (String input) {
                  input = input.toUpperCase();
                  print(input);
                  setState(() {});
                },
                onEditingComplete: () {
                  _controller.clear();
                },
              ),
              trailing:
                  DropdownButton(items: voltDownMenuItems, onChanged: null),
            ),
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
  }) : _controller = controller;

  final TextEditingController _controller;
  final List<DropdownMenuItem<int>> dropDownMenuItems;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextField(
        cursorWidth: 3.5,
        controller: _controller,
        maxLength: 14,
        cursorColor: Color(0xff98DEDA),
        style: textStyling(fontSize: 30),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'current',
          counter: Offstage(),
        ),
        onChanged: (String input) {
          input = input.toUpperCase();
          print(input);
        },
        onEditingComplete: () {
          _controller.clear();
        },
      ),
      trailing: DropdownButton(items: dropDownMenuItems, onChanged: null),
    );
  }
}
