import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CustomSliderWithSubTitles extends StatefulWidget {
  double interval;
  double stepSize;
  double min;
  double max;
  double parcelValue;
  bool shouldFormatToPercentage;
  dynamic Function(double) onChangeProgressAction;

  CustomSliderWithSubTitles(
      this.interval,
      this.stepSize,
      this.min,
      this.max,
      this.parcelValue,
      this.shouldFormatToPercentage,
      this.onChangeProgressAction,
      {Key? key})
      : super(key: key);

  @override
  CustomSliderWithSubTitlesState createState() =>
      CustomSliderWithSubTitlesState();
}

class CustomSliderWithSubTitlesState extends State<CustomSliderWithSubTitles> {
  late double screenWidth;
  late double screenHeight;
  late Orientation screenOrientation;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    screenOrientation = MediaQuery.of(context).orientation;

    return SizedBox(
      width: screenWidth,
      child: SfSlider(
        min: widget.min,
        labelFormatterCallback: (nothing, value) {
          if (widget.shouldFormatToPercentage) {
            return "$value%";
          } else {
            return value;
          }
        },
        max: widget.max,
        value: widget.parcelValue,
        interval: widget.interval,
        showLabels: true,
        enableTooltip: true,
        showDividers: false,
        activeColor: Colors.teal,
        showTicks: false,
        stepSize: widget.stepSize,
        onChanged: (dynamic value) {
          setState(() {
            widget.parcelValue = value;
            changeValueReference(value);
          });
        },
      ),
    );
  }

  changeValueReference(double value) {
    widget.onChangeProgressAction(value);
  }
}
