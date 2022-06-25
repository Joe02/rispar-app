import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:requests/requests.dart';
import 'package:risparapp/Models/CreditBodyInfo.dart';
import 'package:risparapp/Models/UserCredentials.dart';
import 'package:risparapp/Ui/RequestResultScreen/RequestResultScreen.dart';
import 'package:risparapp/Ui/Widgets/DefaultSubmitButton.dart';

import '../../strings.dart';

class RequestWaitingScreen extends StatefulWidget {
  UserCredentials userCredentials;
  CreditBodyInfo creditBodyInfo;
  dynamic Function() onRequestSuccess;
  dynamic Function() openNewSimulation;

  RequestWaitingScreen(this.userCredentials, this.creditBodyInfo,
      this.onRequestSuccess, this.openNewSimulation,
      {Key? key})
      : super(key: key);

  @override
  RequestWaitingScreenState createState() => RequestWaitingScreenState();
}

class RequestWaitingScreenState extends State<RequestWaitingScreen> {
  dynamic jsonResponse;
  bool finishedRequest = false;

  @override
  Widget build(BuildContext context) {
    return finishedRequest
        ? RequestResultScreen(
            reEnableProgressBar,
            newSimulation,
            jsonResponse,
          )
        : FutureBuilder(
            future: postCreditRequest(),
            builder: (
              BuildContext context,
              AsyncSnapshot snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return buildLoadingScreenWidgets();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return buildErrorScreen();
                } else if (snapshot.hasData) {
                  finishedRequest = true;
                  return RequestResultScreen(
                    reEnableProgressBar,
                    newSimulation,
                    jsonResponse,
                  );
                } else {
                  return buildLoadingScreenWidgets();
                }
              } else {
                return buildLoadingScreenWidgets();
              }
            },
          );
  }

  postCreditRequest() async {
    var creditPostRequest = await Requests.post(
      'https://api.rispar.com.br/acquisition/simulation',
      body: {
        'fullname': widget.userCredentials.name,
        'email': widget.userCredentials.email,
        'ltv': widget.creditBodyInfo.ltv,
        'amount': widget.creditBodyInfo.amount,
        'term': widget.creditBodyInfo.term,
        'has_protected_collateral': widget.creditBodyInfo.hasProtectedBoolean
      },
      bodyEncoding: RequestBodyEncoding.JSON,
    );

    creditPostRequest.raiseForStatus();
    jsonResponse = creditPostRequest.json();
    return jsonResponse;
  }

  buildLoadingScreenWidgets() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: LoadingAnimationWidget.threeArchedCircle(
              color: Colors.teal,
              size: 30,
            ),
          ),
          const ListTile(
            title: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                requestWaitingTitleLabel,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                requestWaitingSubTitleLabel,
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  buildErrorScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: Icon(
              Icons.report_gmailerrorred_rounded,
              color: Colors.teal,
            ),
          ),
          const ListTile(
            title: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                requestWaitingErrorTitleLabel,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                requestWaitingErrorSubTitleLabel,
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          DefaultSubmitButton(
              requestWaitingRedoRequestLabel,
              null,
              null,
              null,
              const TextStyle(
                fontSize: 19,
              ), () {
            setState(
              () {},
            );
          })
        ],
      ),
    );
  }

  reEnableProgressBar() {
    widget.onRequestSuccess();
  }

  newSimulation() {
    widget.openNewSimulation();
  }
}
