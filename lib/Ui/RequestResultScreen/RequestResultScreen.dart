import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:risparapp/Models/RequestField.dart';
import 'package:risparapp/Ui/Widgets/DefaultSubmitButton.dart';

import '../../strings.dart';

class RequestResultScreen extends StatefulWidget {
  VoidCallback reEnableProgressBar;
  VoidCallback openNewSimulation;
  dynamic jsonResponse;
  double selectedAmount;

  RequestResultScreen(
    this.reEnableProgressBar,
    this.openNewSimulation,
    this.jsonResponse,
    this.selectedAmount,
  );

  @override
  RequestResultScreenState createState() => RequestResultScreenState();
}

class RequestResultScreenState extends State<RequestResultScreen> {
  final currencyFormatter = NumberFormat("#,##0.00", "pt_BR");
  List<RequestField> requestFieldsList = [];
  late double screenWidth;
  late double screenHeight;
  late Orientation screenOrientation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => widget.reEnableProgressBar(),
    );
    widget.jsonResponse;
    requestFieldsList = [
      RequestField(requestResultFirstFieldLabel,
          "R\$ ${currencyFormatter.format(widget.selectedAmount)}"),
      RequestField(
        requestResultSecondFieldLabel,
        "₿ ${(widget.jsonResponse["collateral"] / 100000000).toStringAsFixed(8)}",
      ),
      RequestField(
        requestResultThirdFieldLabel,
        "${widget.jsonResponse["interest_rate"].toStringAsFixed(2)}% a.m",
      ),
      RequestField(
        requestResultFourthFieldLabel,
        "${widget.jsonResponse["ltv"].toStringAsFixed(0)}%",
      ),
      RequestField(
        requestResultFifthFieldLabel,
        DateFormat("dd/MM/yyyy", 'pt_BR').format(
          DateTime.parse(widget.jsonResponse["first_due_date"]),
        ),
      ),
      RequestField(
        requestResultSixthFieldLabel,
        "R\$ ${currencyFormatter.format(widget.jsonResponse["iof_fee"])}",
      ),
      RequestField(
        requestResultSeventhFieldLabel,
        "R\$ ${widget.jsonResponse["origination_fee"].toStringAsFixed(2)}",
      ),
      RequestField(
        requestResultEighthFieldLabel,
        "R\$ ${currencyFormatter.format(widget.jsonResponse["contract_value"])}",
      ),
      RequestField(
        requestResultNinthFieldLabel,
        "${widget.jsonResponse["monthly_rate"].toStringAsFixed(2)}%",
      ),
      RequestField(
        requestResultTenthFieldLabel,
        "${widget.jsonResponse["annual_rate"].toStringAsFixed(2)}%",
      ),
      RequestField(
        requestResultEleventhFieldLabel,
        "R\$ ${currencyFormatter.format(widget.jsonResponse["collateral_unit_price"])}",
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    screenOrientation = MediaQuery.of(context).orientation;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Spacer(
            flex: 1,
          ),
          const Text(
            requestResultLabel,
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(
            flex: 4,
          ),
          SizedBox(
            height: screenOrientation == Orientation.portrait ? screenHeight * 0.6 : screenWidth * 0.2,
            child: ListView.builder(
              itemCount: requestFieldsList.length,
              itemBuilder: (BuildContext context, int index) {
                return buildResponseRow(
                  requestFieldsList[index].title,
                  requestFieldsList[index].value,
                );
              },
            ),
          ),
          const Spacer(
            flex: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DefaultSubmitButton(
              requestResultNewSimulationLabel,
              null,
              null,
              null,
              const TextStyle(
                fontSize: 19,
              ),
              newSimulation,
            ),
          )
        ],
      ),
    );
  }

  buildResponseRow(String title, String value) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 2,
          thickness: 1,
        ),
      ],
    );
  }

  newSimulation() {
    widget.openNewSimulation();
  }
}
