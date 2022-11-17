import 'dart:math';

import 'package:flutter/cupertino.dart';

class BmiChangeNotifierController extends ChangeNotifier {
  var bmiResult = 0.0;

  Future<void> calculateBmi(
      {required double weight, required double height}) async {
    bmiResult = 0.0;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    bmiResult = weight / pow(height, 2);
    notifyListeners();
  }
}
