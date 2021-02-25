import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:resistohms/color_picker.dart';
import 'package:resistohms/custom_icons/smd_resistor_icons.dart';
import 'package:resistohms/pages/Smd_resistance_calculator.dart';
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
      // routes: {
      //   // When navigating to the "/" route, build the FirstScreen widget.
      //   '/first': (context) => ColorCodeCalculator(),
      //   // When navigating to the "/second" route, build the SecondScreen widget.
      //   '/second': (context) => SmdResistanceCalculator(),
      // },
      title: 'RESISTANCE',
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
  int _selectedItemPosition = 0;
  ShapeBorder bottomBarShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)));
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('RESIST'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings_applications,
                size: 30,
              ),
              onPressed: () async {
                showDialog(
                  builder: (_) => Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      
                      children: [
                       // Text('Select background Color'),
                        CircleColorPicker(),
                        // RaisedButton(
                        //   child: Text('Change Background Color'),
                        //   onPressed: () {},
                        // ),
                        CheckboxListTile(
                          value: false,
                          onChanged: (bool) {},
                          title: Text('data'),
                          subtitle: Text('color'),
                        ),
                        CheckboxListTile(
                          value: false,
                          onChanged: (bool) {},
                          title: Text('data'),
                          subtitle: Text('color'),
                        )
                      ],
                    ),
                  ),
                  context: context,
                );
              },
            ),
          ],
        ),
        backgroundColor: Color(0xff305A3F),
        body: IndexedStack(
          index: _selectedItemPosition,
          children: [
            for (final tabItem in TabNavigationItem.items) tabItem.page,
          ],
        ),
        bottomNavigationBar: SnakeNavigationBar.color(
          elevation: 20.0,
          behaviour: SnakeBarBehaviour.floating,
          snakeShape: SnakeShape.rectangle,
          // shape: bottomBarShape,
          currentIndex: _selectedItemPosition,
          onTap: (index) {
            setState(() {
              _selectedItemPosition = index;
            });
          },

          selectedLabelStyle: textStyling(fontSize: 16),
          unselectedLabelStyle: textStyling(fontSize: 14),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          items: [
            for (final tabItem in TabNavigationItem.items)
              BottomNavigationBarItem(
                icon: tabItem.icon,
                label: tabItem.label,
              )
          ],
        ));
  }
}

class TabNavigationItem {
  final Widget page;
  // final Widget title;
  final Icon icon;
  final String label;

  TabNavigationItem(
      {@required this.page, @required this.icon, @required this.label});

  static const IconData ohms_lawIcon =
      IconData(0xe803, fontFamily: 'MyFlutterApp', fontPackage: null);
  static const IconData resistor_color_codesIcon =
      IconData(0xe804, fontFamily: 'ResistorColorCode', fontPackage: null);

  static const IconData smd_icon =
      IconData(0xe809, fontFamily: 'Smd', fontPackage: null);

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: ColorCodeCalculator(),
          icon: Icon(resistor_color_codesIcon),
          label: 'Color codes',
        ),
        TabNavigationItem(
          page: SmdResistanceCalculator(),
          icon: Icon(ohms_lawIcon),
          label: 'Ohms Law calc',
        ),
        TabNavigationItem(
          page: SmdResistanceCalculator(),
          icon: Icon(smd_icon),
          label: 'SMD resistors',
        ),
        TabNavigationItem(
          page: Text('data'),
          icon: Icon(Icons.rate_review),
          label: 'Rate 5 stars',
        ),
      ];
}
