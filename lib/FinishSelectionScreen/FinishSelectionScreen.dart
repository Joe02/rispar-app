import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:risparapp/Widgets/CustomSliderWithSubTitles.dart';
import 'package:risparapp/Widgets/DefaultSubmitButton.dart';

import '../strings.dart';

class FinishSelectionScreen extends StatefulWidget {
  double chosenValue;
  dynamic Function(double, double) onClickAction;

  FinishSelectionScreen(this.chosenValue, this.onClickAction);

  @override
  FinishSelectionScreenState createState() => FinishSelectionScreenState();
}

class FinishSelectionScreenState extends State<FinishSelectionScreen> {
  late double screenWidth;
  late double screenHeight;
  late Orientation screenOrientation;
  double _parcelSliderValue = 3.0;
  double _warrantySliderValue = 20.0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    screenOrientation = MediaQuery.of(context).orientation;

    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          height: screenOrientation == Orientation.portrait
              ? screenHeight * 0.85
              : screenWidth * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildScreenSelectedValueLabel(),
              const SizedBox(
                height: 30,
              ),
              buildParcelsSlider(),
              const SizedBox(
                height: 30,
              ),
              buildWarrantySlider(),
              const SizedBox(
                height: 30,
              ),
              buildProtectedWarranty(),
              buildSubmitButtons()
            ],
          ),
        ),
      ),
    );
  }

  buildScreenSelectedValueLabel() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 17.5,
      ),
      child: ListTile(
        title: const Text(
          finishSelectionSelectedValueLabel,
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
          ),
          child: Text(
            "R\$${widget.chosenValue.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 35,
              color: Colors.teal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  buildParcelsSlider() {
    return ListTile(
      title: Center(
        child: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text: finishSelectionTitleParcelLabel,
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
              TextSpan(
                text: finishSelectionSubTitleParcelLabel,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            ],
          ),
        ),
      ),
      subtitle: CustomSliderWithSubTitles(
        3,
        3,
        3.0,
        12.0,
        _parcelSliderValue,
        false,
        onParcelSliderProgressChanged,
      ),
    );
  }

  onParcelSliderProgressChanged(double value) {
    setState(() {
      _parcelSliderValue = value;
    });
  }

  buildWarrantySlider() {
    return ListTile(
      title: Center(
        child: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text: finishSelectionTitleWarrantyLabel,
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
              TextSpan(
                text: finishSelectionSubTitleWarrantyLabel,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            ],
          ),
        ),
      ),
      subtitle: CustomSliderWithSubTitles(
        15,
        15,
        20.0,
        50.0,
        _warrantySliderValue,
        true,
        onWarrantySliderProgressChanged,
      ),
    );
  }

  onWarrantySliderProgressChanged(double value) {
    setState(() {
      _warrantySliderValue = value;
    });
  }

  buildProtectedWarranty() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 17.5,
        vertical: 10.0,
      ),
      child: ListTile(
        title: Text(
          finishSelectionInfoTitleLabel,
          style: TextStyle(
              fontSize: 22, color: Colors.teal, fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(
            top: 15.0,
          ),
          child: Text(
            finishSelectionInfoSubTitleLabel,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  buildSubmitButtons() {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        DefaultSubmitButton(
          finishSelectionContinueWithoutProtectedWarranty,
          Colors.transparent,
          null,
          Colors.white,
          const TextStyle(fontSize: 19, color: Colors.teal),
          onContinueWithoutProtectedWarranty,
        ),
        DefaultSubmitButton(
          finishSelectionContinueWithProtectedWarranty,
          null,
          null,
          Colors.white,
          const TextStyle(fontSize: 19),
          onContinueWithProtectedWarranty,
        )
      ],
    );
  }

  onContinueWithoutProtectedWarranty() {
    widget.onClickAction(_parcelSliderValue, _warrantySliderValue);
  }

  onContinueWithProtectedWarranty() {
    widget.onClickAction(_parcelSliderValue, _warrantySliderValue);
  }
}
