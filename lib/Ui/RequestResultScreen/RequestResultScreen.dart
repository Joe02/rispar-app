import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:risparapp/Ui/Widgets/DefaultSubmitButton.dart';

class RequestResultScreen extends StatefulWidget {
  VoidCallback reEnableProgressBar;
  VoidCallback openNewSimulation;
  dynamic jsonResponse;

  RequestResultScreen(
    this.reEnableProgressBar,
    this.openNewSimulation,
    this.jsonResponse,
  );

  @override
  RequestResultScreenState createState() => RequestResultScreenState();
}

class RequestResultScreenState extends State<RequestResultScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => widget.reEnableProgressBar(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 1,
          ),
          const Text(
            "Resultado da simulação",
            style: const TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(
            flex: 4,
          ),
          buildResponseRow("Valor escolhido"),
          buildResponseRow("Garantia"),
          buildResponseRow("Taxa de juros"),
          buildResponseRow("Percentual de garantia"),
          buildResponseRow("Primeiro vencimento"),
          buildResponseRow("IOF"),
          buildResponseRow("Tarifa de plataforma"),
          buildResponseRow("Total financiado"),
          buildResponseRow("CET mensal"),
          buildResponseRow("CET anual"),
          buildResponseRow("Cotação do BTC"),
          const Spacer(
            flex: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DefaultSubmitButton(
              "Nova simulação",
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

  buildResponseRow(String title) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )
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
