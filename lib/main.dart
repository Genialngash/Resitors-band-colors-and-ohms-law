import 'color_code_calculator.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true  ,
        title: Text('RESIST'),
      ),
      body: Container(
        
        alignment: Alignment.center,
       // color: Colors.blueGrey,
       decoration: BoxDecoration(
         
       gradient: RadialGradient(
        
         colors: [Color(0xff254B21),Color(0xff357A2C),Color(0xff174511)],
       )
       ),
        child: ColorCodeCalculator(),
      ),
    );
  }
}