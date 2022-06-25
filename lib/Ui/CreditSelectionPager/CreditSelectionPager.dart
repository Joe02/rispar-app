import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:risparapp/Models/CreditBodyInfo.dart';
import 'package:risparapp/Models/UserCredentials.dart';
import 'package:risparapp/Ui/CreditSelectionScreen/CreditSelectionScreen.dart';

import '../FinishSelectionScreen/FinishSelectionScreen.dart';
import '../RequestWaitingScreen/RequestWaitingScreen.dart';

class CreditSelectionPager extends StatefulWidget {
  UserCredentials userCredentials;

  CreditSelectionPager(this.userCredentials);

  @override
  CreditSelectionPagerState createState() => CreditSelectionPagerState();
}

class CreditSelectionPagerState extends State<CreditSelectionPager> {
  bool _shouldExhibitProgressBar = true;
  bool _shouldExhibitExitIcon = false;
  double progressIndicator = 0.3;
  double selectedValue = 0.0;
  int term = 0;
  int ltv = 0;
  bool hasProtectedCollateral = false;
  late double screenWidth;
  late double screenHeight;
  late Orientation screenOrientation;
  late UserCredentials userCredentials;
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    userCredentials = widget.userCredentials;
  }

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
        actions: [
          Visibility(
            visible: _shouldExhibitExitIcon,
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: InkResponse(
                onTap: () {
                  _shouldExhibitExitIcon = false;
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.teal,
                  size: 30,
                ),
              ),
            ),
          )
        ],
        title: SizedBox(
          width: screenOrientation == Orientation.portrait
              ? screenHeight * 0.30
              : screenWidth * 0.80,
          child: Visibility(
            visible: _shouldExhibitProgressBar,
            child: LinearProgressIndicator(
              color: Colors.teal,
              backgroundColor: Colors.grey,
              value: progressIndicator,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        allowImplicitScrolling: false,
        children: [
          CreditSelectionScreen(
            onCreditSelection,
          ),
          FinishSelectionScreen(
            selectedValue,
            submitCreditRequest,
          ),
          RequestWaitingScreen(
              userCredentials,
              CreditBodyInfo(
                ltv,
                selectedValue,
                term,
                hasProtectedCollateral,
              ),
              onRequestSuccess,
              newSimulation),
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

  submitCreditRequest(
      double parcelValue, double warrantyValue, bool protectedWarranty) {
    setState(
      () {
        _shouldExhibitProgressBar = false;
        ltv = warrantyValue.toInt();
        term = parcelValue.toInt();
        hasProtectedCollateral = protectedWarranty;
        _controller.nextPage(
          duration: const Duration(
            milliseconds: 500,
          ),
          curve: Curves.easeIn,
        );
      },
    );
  }

  onRequestSuccess() {
    setState(() {
      _controller.nextPage(
        duration: const Duration(
          milliseconds: 500,
        ),
        curve: Curves.easeIn,
      );
      progressIndicator = 1.0;
      _shouldExhibitExitIcon = true;
      _shouldExhibitProgressBar = true;
    });
  }

  newSimulation() {
    setState(() {
      _controller.animateToPage(
        _controller.initialPage,
        duration: const Duration(
          milliseconds: 500,
        ),
        curve: Curves.easeIn,
      );
      progressIndicator = 0.3;
      _shouldExhibitExitIcon = false;
      _shouldExhibitProgressBar = true;
    });
  }

  removeProgress() {
    if (_controller.page == 0) {
      Navigator.pop(context);
    } else {
      backToPreviousPage();
      if (progressIndicator == 0.6) {
        setState(() {
          progressIndicator = 0.3;
        });
      } else {
        setState(
          () {
            progressIndicator = 0.6;
          },
        );
      }
    }
  }

  backToPreviousPage() {
    setState(
      () {
        _controller.previousPage(
          duration: const Duration(
            milliseconds: 500,
          ),
          curve: Curves.ease,
        );
        _shouldExhibitExitIcon = false;
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
