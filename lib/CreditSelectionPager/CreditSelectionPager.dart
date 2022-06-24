import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:risparapp/CreditSelectionScreen/CreditSelectionScreen.dart';

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
        children: [
          CreditSelectionScreen(
            submitCreditRequest,
          ),
        ],
      ),
    );
  }

  submitCreditRequest(double? value) {
    if (value != null) {
      setState(() {
        _controller.nextPage(
          duration: const Duration(seconds: 1),
          curve: Curves.bounceIn,
        );
      });
      setState(() {
        progressIndicator = 0.6;
      });
    }
  }

  removeProgress() {
    if (_controller.page == 0) {
      Navigator.pop(context);
    } else {
      setState(() {
        _controller.previousPage(
          duration: const Duration(seconds: 1),
          curve: Curves.bounceOut,
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
