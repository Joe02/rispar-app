import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultSubmitButton extends StatelessWidget {
  String title;
  Color? primary;
  Color? onPrimary;
  Color? shadowColor;
  TextStyle? textStyle;
  VoidCallback buttonAction;
  late double screenWidth;
  late double screenHeight;
  late Orientation screenOrientation;

  DefaultSubmitButton(this.title, this.primary, this.onPrimary,
      this.shadowColor, this.textStyle, this.buttonAction,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    screenOrientation = MediaQuery.of(context).orientation;

    return ElevatedButton(
      child: SizedBox(
        width: screenOrientation == Orientation.portrait
            ? screenWidth * 0.85
            : screenWidth * 0.925,
        height: 60,
        child: Center(
          child: Text(
            title,
            style: textStyle ?? TextStyle(),
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: primary ?? Colors.teal[300],
        onPrimary: onPrimary ?? Colors.white,
        shadowColor: shadowColor ?? Colors.black,
        elevation: 5,
      ),
      onPressed: buttonAction,
    );
  }
}
