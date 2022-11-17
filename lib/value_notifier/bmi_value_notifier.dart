import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/bmi_gauge.dart';

class BmiValueNotifier extends StatefulWidget {
  const BmiValueNotifier({Key? key}) : super(key: key);

  @override
  State<BmiValueNotifier> createState() => _BmiValueNotifierState();
}

class _BmiValueNotifierState extends State<BmiValueNotifier> {
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  var bmiResult = ValueNotifier(0.0);
  final _formKey = GlobalKey<FormState>();

  void _calculateBmi({required double weight, required double height}) async {
    bmiResult.value = 0.0;
    await Future.delayed(const Duration(seconds: 1));
    bmiResult.value = weight / pow(height, 2);
  }

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('----------------------------------------');
    print('Build tela completa');
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Value Notifier'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ValueListenableBuilder<double>(
                    valueListenable: bmiResult,
                    builder: (__, bmiResultValue, _) {
                      print('----------------------------------------');
                      print('Build tela ValueListenable');
                      return BmiGauge(bmiResult: bmiResultValue);
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Weigth '),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                        locale: 'pt_br',
                        symbol: '',
                        decimalDigits: 2,
                        turnOffGrouping: true)
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mandatory Weight field';
                    }
                  },
                ),
                TextFormField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Height '),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                        locale: 'pt_BR',
                        symbol: '',
                        decimalDigits: 2,
                        turnOffGrouping: true),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mandatory Height field';
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    var formValidate =
                        _formKey.currentState?.validate() ?? false;

                    if (formValidate) {
                      var formatter = NumberFormat.simpleCurrency(
                          locale: 'pt_BR', decimalDigits: 2);
                      double weight =
                          formatter.parse(weightController.text) as double;
                      double height =
                          formatter.parse(heightController.text) as double;
                      _calculateBmi(weight: weight, height: height);
                    }
                  },
                  child: const Text('Calculate BMI'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
