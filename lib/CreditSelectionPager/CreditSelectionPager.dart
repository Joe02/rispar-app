import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:risparapp/CreditSelectionScreen/CreditSelectionScreen.dart';

import '../FinishSelectionScreen/FinishSelectionScreen.dart';

class CreditSelectionPager extends StatefulWidget {
  @override
  CreditSelectionPagerState createState() => CreditSelectionPagerState();
}

class CreditSelectionPagerState extends State<CreditSelectionPager> {
  double progressIndicator = 0.3;
  final PageController _controller = PageController(
    initialPage: 0,
  );
  late double screenWidth;
  late double screenHeight;
  late Orientation screenOrientation;
  double selectedValue = 0.0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    screenOrientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkResponse(
          onTap: removeProgress,
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.teal,
          ),
        ),
        title: Container(
          width: screenOrientation == Orientation.portrait
              ? screenHeight * 0.30
              : screenWidth * 0.80,
          child: LinearProgressIndicator(
            color: Colors.teal,
            backgroundColor: Colors.grey,
            value: progressIndicator,
            semanticsLabel: 'Linear progress indicator',
          ),
        ),
        elevation: 0,
      ),
      body: PageView(
        controller: _controller,
        allowImplicitScrolling: false,
        children: [
          CreditSelectionScreen(
            onCreditSelection,
          ),
          FinishSelectionScreen(
            selectedValue,
            submitCreditRequest,
          )
        ],
      ),
    );
  }

  onCreditSelection(double? value) {
    if (value != null) {
      setState(() {
        _controller.nextPage(
          duration: const Duration(
            milliseconds: 500,
          ),
          curve: Curves.easeIn,
        );
        progressIndicator = 0.6;
        selectedValue = value;
      });
    }
  }

  submitCreditRequest(double parcelValue, double warrantyValue) {
    print(
        "TODO REQUEST(parcelValue = ${parcelValue} & warrantyValue = ${warrantyValue})\n");
  }

  removeProgress() {
    if (_controller.page == 0) {
      Navigator.pop(context);
    } else {
      setState(() {
        _controller.previousPage(
          duration: const Duration(
            milliseconds: 500,
          ),
          curve: Curves.ease,
        );
      });
      if (progressIndicator == 0.6) {
        setState(() {
          progressIndicator = 0.3;
        });
      } else {
        setState(() {
          progressIndicator = 0.6;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
