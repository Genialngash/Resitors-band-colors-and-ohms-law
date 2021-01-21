import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:resistohms/constants.dart';

typedef onChange = void Function(Color color);

class ColorPicker extends StatefulWidget {
  final double width;
  final ValueChanged<Color> onColorChanged;
  final ValueChanged<String> onSubmitColorName;

  ColorPicker({this.width, this.onColorChanged, this.onSubmitColorName});

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  final List<Color> _colors = [
    Color(0xffff0000),
    Color(0xffA52A2A),
    Color(0xffffA500), //orange
    Color(0xffFFD700), //gold
    Color(0xffffff00), //yellow
    Color(0xff008000),
    Color(0xff0000ff),
    Color(0xffEE82EE),
    Color(0xff000000),
    Color(0xff808080),
    Color(0xffffffff),
    Color(0xffC0C0C0)
  ];

  double _colorSliderPosition = 0;
  Color currentColor;

  _colorChangeHandler(double position) {
    //handle out of bounds positions
    if (position > widget.width) {
      position = widget.width;
    }
    if (position < 0) {
      position = 0;
    }
    print("New position: $position");
    setState(() {
      _colorSliderPosition = position;
      _calculateSelecteColor(_colorSliderPosition);
    });
    widget.onColorChanged(currentColor);
  }

  Color _calculateSelecteColor(double position) {
//determine color
    double positionInColorArray =
        (position / widget.width * (_colors.length - 1));
    print(positionInColorArray);
    int index = positionInColorArray.truncate();
    print(index);
    double remainder = positionInColorArray - index;
    if (remainder == 0.0) {
      currentColor = _colors[index];
    } else {
      //calculate new color
      int redValue = _colors[index].red == _colors[index + 1].red
          ? _colors[index].red
          : (_colors[index].red +
                  (_colors[index + 1].red - _colors[index].red) * remainder)
              .round();
      int greenValue = _colors[index].green == _colors[index + 1].green
          ? _colors[index].green
          : (_colors[index].green +
                  (_colors[index + 1].green - _colors[index].green) * remainder)
              .round();
      int blueValue = _colors[index].blue == _colors[index + 1].blue
          ? _colors[index].blue
          : (_colors[index].blue +
                  (_colors[index + 1].blue - _colors[index].blue) * remainder)
              .round();

      currentColor = Color.fromARGB(255, redValue, greenValue, blueValue);
    }

    return currentColor;
  }

  @override
  void initState() {
    super.initState();
    currentColor = _calculateSelecteColor(_colorSliderPosition);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Column(
      children: <Widget>[
        Center(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragStart: (DragStartDetails details) {
              _colorChangeHandler(details.localPosition.dx);
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              _colorChangeHandler(details.localPosition.dx);
            },
            onTapDown: (TapDownDetails details) {
              _colorChangeHandler(details.localPosition.dx);
            },
            //This outside padding makes it much easier to grab the slider because the gesture
            //detector has the extra padding to recognize gestures insider of
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: widget.width,
                height: 20,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Color(0xff062424)),
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(colors: _colors)),
                child: CustomPaint(
                  painter: _SliderIndicatorPainter(_colorSliderPosition),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 35,
        ),
        buildDialog(
            controller: controller,
            color: currentColor,
            onSubmit: widget.onSubmitColorName)
      ],
    );
  }
}

class _SliderIndicatorPainter extends CustomPainter {
  final double position;

  _SliderIndicatorPainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        //takes a position input and draws a circle at the current position,vertically centered
        //(which is where size.height/2 comes from in the offset)
        Offset(position, size.height / 2),
        14,
        Paint()..color = Colors.black87);
  }

  @override
  bool shouldRepaint(_SliderIndicatorPainter old) {
    return true;
  }
}
