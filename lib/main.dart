
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:resistohms/pages/Ohms_Law_calculator.dart';
import 'package:resistohms/pages/Smd_resistance_calculator.dart';
import 'package:resistohms/pages/support_page.dart';
import 'ad_manager.dart';
import 'constants.dart';
import 'color_code_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
 // MobileAds.instance.initialize();
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
  Future<void> _initAdMob() {
    return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }

  @override
  void initState() {
    _initAdMob();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('OHM\'S RESISTANCE'),
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
          page: OhmsLawCalculator(),
          icon: Icon(ohms_lawIcon),
          label: 'Ohms Law ',
        ),
        TabNavigationItem(
          page: SmdResistanceCalculator(),
          icon: Icon(smd_icon),
          label: 'SMD',
        ),
        TabNavigationItem(
          page: RatingPage(),
          icon: Icon(Icons.rate_review),
          label: 'Support',
        ),
      ];
}
