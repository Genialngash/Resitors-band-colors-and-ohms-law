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
        //margin: EdgeInsets.all(20),
        alignment: Alignment.center,
       // color: Colors.blueGrey,
       decoration: BoxDecoration(
       gradient: LinearGradient(
         colors: [Color(0xff6B79A3),Color(0xff20355A)],
       )
       ),
        child: ColorCodeCalculator(),
      ),
    );
  }
}