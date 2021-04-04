import 'package:flutter/material.dart';
import 'package:resistohms/color_picker.dart';

class RatingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    
double screenWidth = MediaQuery.of(context).size.width;

    return Container(

      child: ColorPicker(  width: screenWidth-50,
                        onColorChanged: (Color color) async {
                          print(color);
                          }),
                        
                      
    );
  }
}