import 'package:flutter/material.dart';
import 'package:resistohms/constants.dart';
import 'package:color_convert/color_convert.dart';
import 'dart:math';

class SmdResistanceCalculator extends StatefulWidget {
  @override
  _SmdResistanceCalculatorState createState() =>
      _SmdResistanceCalculatorState();
}

class _SmdResistanceCalculatorState extends State<SmdResistanceCalculator> {
  TextEditingController _controller = TextEditingController();
  var userInput;
  String hintText = '0R5';
  var finalAnswer = '0.5';
  var output;
  String errorMessage = 'ERROR: type the correct SMD code!';

  // change the final Answer to MegaOhms/KiloOhms/gigaOhms
  String formatAnswer(var answer) {
    if (answer > 1000000000) {
      finalAnswer = (answer / (1000000000)).toString() + ' gigaOhms';
    } else if (answer > 1000000) {
      finalAnswer = (answer / (1000000)).toString() + ' megaOhms';
    } else if (answer > 1000) {
      finalAnswer = (answer / (1000)).toString() + ' kiloOhms';
    } else {
      finalAnswer = answer.toString() + ' Ohms';
    }
    return finalAnswer;
  }

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
                buildSmdEndContainer(),
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
                          input = input.toUpperCase();
                          print(input);
                          setState(() {
                            userInput = input;
                          });
                        },
                        onEditingComplete: () {
                          _controller.clear();
                        },
                      ),
                    )),
              buildSmdEndContainer(),
              ],
            ),
            Text(
              output ?? '0.5',
              style: textStyling(fontSize: 30),
            ),
            RaisedButton(
              color: Color(0xffA8AF9C),
              splashColor: Color(0xffB7D874),
              
             animationDuration: Duration(seconds: 1),
              child:Text('CALCULATE'),
                onPressed: () {
                  //check if the user has input more than one alphabet
                  if (userInput.lastIndexOf(RegExp(r'[A-Z]')) >
                      userInput.lastIndexOf(RegExp(r'[A-Z]'))) {
                    print('error');

                    finalAnswer = errorMessage;
                  } else if ((userInput.length == 3 || userInput.length == 4) &&
                      (userInput.contains('R'))) {
                    //check first if it has R and replace it with a dot
                    if (userInput.contains('R')) {
                      finalAnswer = userInput.replaceAll('R', '.');
                      print('has r');
                      //check if the answer contains alphabets and output an error
                      if (finalAnswer.contains(RegExp(r'[A-Z]'))) {
                        finalAnswer = errorMessage;
                      }
                      //if it ends with an R
                      else if (finalAnswer.endsWith('.')) {
                        finalAnswer = finalAnswer.replaceAll('.', ' Ohms');
                      }
                      //if it starts with an R
                      else if (finalAnswer.startsWith('.')) {
                        finalAnswer = '0' + finalAnswer + ' Ohms';
                      }
                    }
                  } else if (userInput.length == 3 &&
                      userInput.contains(RegExp(r'[A-Z]')) &&
                      userInput.contains(RegExp(r'[0-9]'))) {
                    List inptSplit = userInput.split('');

                    try {
                      int input = int.tryParse(inptSplit[0] + inptSplit[1]) - 1;
                      print(inptSplit);
                      print(input);
                      //from the geometric progression formula that produces the codes for EIA system
                      var eia_96Code =
                          (pow(10, (input) / 96) * 100).round().toInt();
                      print(eia_96Code);
                      //The third letter acts as a multiplier with a certain value
                      Map<String, double> eia_96Letter = {
                        'Z': 0.001,
                        'Y': 0.01,
                        'R': 0.01,
                        'X': 0.1,
                        'S': 0.1,
                        'A': 1,
                        'B': 10,
                        'H': 10,
                        'C': 100,
                        'D': 1000,
                        'E': 10000,
                        'F': 100000,
                      };
                      for (var item in eia_96Letter.keys) {
                        if (item == inptSplit[2]) {
                          print(item);
                          var answer = (eia_96Code * eia_96Letter[item]);
                          finalAnswer = formatAnswer(answer);
                          break;
                        } else {
                          finalAnswer = errorMessage;
                        }
                      }
                    } catch (e) {
                      finalAnswer = errorMessage;
                    }
                  }
                  //check if the user inputs <= 2 characters (if they are letters ,show an error message)
                  else if ((userInput.length == 2 || userInput.length == 1) &&
                      (userInput.contains(RegExp(r'[A-Z]')) == false)) {
                    finalAnswer = userInput + ' Ohms';
                  } else {
                    var ans = userInput.split(
                        ''); // if answer is numeric ,split it to make a List

                    try {
                      print(ans);
                      // Join the first 2/3(if its 3/4 digit code resistor )
                      // power the last digit by 10
                      var answer = userInput.length == 3
                          ? int.tryParse(ans[0] + ans[1]) *
                              pow(10, int.tryParse(ans[2]))
                          : int.tryParse(ans[0] + ans[1] + ans[2]) *
                              pow(10, int.tryParse(ans[3]));
                      // change the final Answer to MegaOhms/KiloOhms/gigaOhms
                      finalAnswer = formatAnswer(answer);
                    } catch (e) {
                      finalAnswer = errorMessage;
                    }
                  }
                  setState(() {
                    output = finalAnswer;
                  });
                }, 
            )
          ],
        ),
      ),
    );
  }

  
}
