import 'package:flutter/material.dart';


class  Demo1 with ChangeNotifier {

  int value = 0;
  increment() {
    value++;
    notifyListeners();
  }
}