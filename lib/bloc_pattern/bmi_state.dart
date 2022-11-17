import 'package:flutter_default_state_manager/setState/bmi_set_state.dart';

class BmiState {
  final double? bmiResult;

  BmiState({this.bmiResult});
}

class BmiStateLoading extends BmiState {}

class BmiStateError extends BmiState {
  final String message;
  BmiStateError({required this.message});
}
