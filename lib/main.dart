// @dart=2.9

import 'package:flutter/material.dart';
import 'package:risparapp/UserInfoScreen/UserInfoScreen.dart';

void main() {
  runApp(const RisparApp());
}

class RisparApp extends StatelessWidget {
  const RisparApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserInfoScreen()
    );
  }
}