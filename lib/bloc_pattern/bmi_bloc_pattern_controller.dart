import 'dart:async';
import 'dart:math';

import 'package:flutter_default_state_manager/bloc_pattern/bmi_state.dart';

class BmiBlocPatternController {
  final _bmiStreamController = StreamController<BmiState>.broadcast()
    ..add(BmiState(bmiResult: 0.0));
  //Sink<BmiState> get bmiIn => _bmiStreamController.sink; => works just like the add on strem.add()
  //Sink is more used to make calls outside the controller
  Stream<BmiState> get bmiOut => _bmiStreamController.stream;
  Future<void> calculateBmi(
      {required double weight, required double height}) async {
    try {
      _bmiStreamController.add(BmiStateLoading());
      await Future.delayed(const Duration(seconds: 1));
      final bmiResult = weight / pow(height, 2);
      //throw Exception();
      _bmiStreamController.add(BmiState(bmiResult: bmiResult));
    } on Exception catch (e) {
      _bmiStreamController.add(BmiStateError(message: 'Erro ao calcular IMC'));
    }
  }

  void dispose() {
    _bmiStreamController.close();
  }
}
