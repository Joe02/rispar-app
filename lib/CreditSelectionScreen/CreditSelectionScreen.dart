import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:risparapp/Widgets/DefaultSubmitButton.dart';

import '../strings.dart';

class CreditSelectionScreen extends StatefulWidget {
  dynamic Function(double?) onClickAction;

  CreditSelectionScreen(this.onClickAction);

  @override
  CreditSelectionScreenState createState() => CreditSelectionScreenState();
}

class CreditSelectionScreenState extends State<CreditSelectionScreen> {
  late double screenWidth;
  late double screenHeight;
  late Orientation screenOrientation;
  final TextEditingController _inputController = MoneyMaskedTextController(
      initialValue: 0.0, thousandSeparator: ",", decimalSeparator: ".");
  bool _validator = true;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    screenOrientation = MediaQuery.of(context).orientation;

    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildUserScreenLabel(),
              Visibility(
                visible: screenOrientation == Orientation.portrait,
                child: const Spacer(),
              ),
              buildScreenInput(),
              Visibility(
                visible: screenOrientation == Orientation.portrait,
                child: const Spacer(),
              ),
              buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  buildUserScreenLabel() {
    return ListTile(
      title: RichText(
        text: const TextSpan(
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.teal,
          ),
          children: <TextSpan>[
            TextSpan(
              text: creditSelectionTitleLabel,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            TextSpan(
              text: creditSelectionSubTitleLabel,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
        ),
        child: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text: creditSelectionDescriptionFirstLabel,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              TextSpan(
                text: creditSelectionDescriptionSecondLabel,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextSpan(
                text: creditSelectionDescriptionThirdLabel,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              TextSpan(
                text: creditSelectionDescriptionFourthLabel,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildScreenInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.teal,
          fontSize: 22,
        ),
        controller: _inputController,
        decoration: InputDecoration(
          icon: const Padding(
            padding: EdgeInsets.only(
              top: 19.0,
            ),
            child: Text(
              "R\$",
              style: TextStyle(
                color: Colors.teal,
                fontSize: 25,
              ),
            ),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          labelText: creditSelectionInputLabel,
          labelStyle: const TextStyle(
            color: Colors.teal,
            fontSize: 20,
          ),
          errorText: _validator ? null : "O valor inserido está incorreto.",
        ),
      ),
    );
  }

  buildSubmitButton() {
    _inputController.text.replaceAll(",", "");
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: DefaultSubmitButton(
        creditSelectionDefaultButtonLabel,
        null,
        null,
        null,
        const TextStyle(fontSize: 19),
        callWidgetAction,
      ),
    );
  }

  callWidgetAction() {
    _inputController.text.replaceFirst(".", "");
    double? value =
        double.tryParse(_inputController.text.replaceFirst(",", ""));
    if (value != null) {
      if (value > 300000 || value < 500) {
        setState(() {
          _validator = false;
        });
      } else {
        setState(() {
          _validator = true;
          widget.onClickAction(
            double.tryParse(
              _inputController.text.replaceFirst(",", ""),
            ),
          );
        });
      }
    } else {
      setState(() {
        _validator = false;
      });
    }
  }
}
