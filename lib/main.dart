// @dart=2.9

import 'package:flutter/material.dart';
import 'package:risparapp/Ui/UserInfoScreen/UserInfoScreen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(const RisparApp());
}

class RisparApp extends StatelessWidget {
  const RisparApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserInfoScreen()
    );
  }
}