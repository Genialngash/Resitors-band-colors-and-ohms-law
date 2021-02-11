
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:resistohms/custom_icons/smd_resistor_icons.dart';
import 'constants.dart';
import 'color_code_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'custom painter',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedItemPosition;
  ShapeBorder bottomBarShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)));

       

  
 
  static const IconData resistor_1_ = IconData(0xe803, fontFamily:'MyFlutterApp', fontPackage: null);
  static const IconData resistor_2_ = IconData(0xe804, fontFamily: 'ResistorColorCode', fontPackage: null);

  static const IconData smd_icon = IconData(0xe809, fontFamily: 'Smd', fontPackage: null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('RESIST'),
        ),
        body: Container(
          alignment: Alignment.center,
          // color: Colors.blueGrey,
          decoration: BoxDecoration(
              gradient: RadialGradient(
            tileMode: TileMode.clamp,
            colors: [
              //Color(0xff192323),
              //Color(0xff213F21),
              Color(0xff114111),
              Color(0xff305A3F),
              Color(0xff305A3F),
              // Color(0xff062424),

              // Color(0xff4D4D55),
            ],
          )),
          child: ColorCodeCalculator(),
        ),
        bottomNavigationBar: SnakeNavigationBar.color(
          elevation: 20.0,
          behaviour: SnakeBarBehaviour.floating,
          snakeShape: SnakeShape.rectangle,
          // shape: bottomBarShape,
          currentIndex: _selectedItemPosition,
          onTap: (index) => setState(() {
            _selectedItemPosition = index;
          }),
          selectedLabelStyle: textStyling(fontSize: 16),
          unselectedLabelStyle: textStyling(fontSize: 14),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          items: [
            BottomNavigationBarItem(
                icon: Icon(resistor_2_), label: 'Color Codes'),
            BottomNavigationBarItem(
                icon: Icon(smd_icon), label: 'SMD resistors'),
            BottomNavigationBarItem(
                icon: Icon(resistor_1_),
                label: 'Ohms Law calc'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
                
          ],
        ));
  }
}
