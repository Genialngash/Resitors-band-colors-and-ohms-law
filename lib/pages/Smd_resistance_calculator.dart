import 'package:flutter/material.dart';
import 'package:resistohms/constants.dart';
import 'package:color_convert/color_convert.dart';

class SmdResistanceCalculator extends StatefulWidget {
  @override
  _SmdResistanceCalculatorState createState() =>
      _SmdResistanceCalculatorState();
}

class _SmdResistanceCalculatorState extends State<SmdResistanceCalculator> {
  TextEditingController _controller = TextEditingController();
  var answer = '0.5';
  String hintText = '0R5';
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
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
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 135,
                  width: 30,
                  color: Colors.grey,
                ),
                Container(
                    height: 130,
                    width: 200,
                    color: Colors.black87,
                    child: Center(
                      child: TextField(
                        cursorWidth: 4.0,
                        controller: _controller,
                        maxLength: 4,
                        //  textCapitalization: TextCapitalization.sentences,

                        cursorColor: Color(0xff98DEDA),
                        style: textStyling(fontSize: 65),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: hintText,
                          hintStyle: textStyling(fontSize: 50),
                        ),
                        onChanged: (String input) {
                         
                        input=  input.toUpperCase(); print(input);
                          setState(() {
                            answer = input;
                          });
                        },
                        onEditingComplete: () {
                          
                          _controller.clear();
                        },
                      ),
                    )),
                Container(
                  height: 135,
                  width: 30,
                  color: Colors.grey,
                ),
              ],
            ),
            Text(
              answer,
              style: textStyling(fontSize: 30),
            ),
            FlatButton(
                onPressed: () {

                  if (answer.length == 3 || answer.length == 4){
                     if (answer.contains('R') ) {
                    print(answer.replaceAll('R', '.'));
                    print('has r');
                  }
                  else{
                    
                  }

                  }


                  else {
                    var finalAnswer = int.tryParse(answer);
                    print(finalAnswer);
                  }
                },
                child: Text('Press me'))
          ],
        ),
      ),
    );
  }
}
