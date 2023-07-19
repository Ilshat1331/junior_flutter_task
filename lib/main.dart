import 'package:flutter/material.dart';
import 'package:junior_test/ui/actions/ActionsWidget.dart';
import 'package:junior_test/ui/actions/item/ActionsItemWidget.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        ActionsItemWidget.routeName: (context) => ActionsItemWidget(),
      },
      home: ActionsWidget(),
    ),
  );
}
