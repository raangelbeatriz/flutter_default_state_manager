import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/bmi_gauge.dart';

class BmiSetStatePage extends StatefulWidget {
  const BmiSetStatePage({Key? key}) : super(key: key);

  @override
  State<BmiSetStatePage> createState() => _BmiSetStatePageState();
}

class _BmiSetStatePageState extends State<BmiSetStatePage> {
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  var bmiResult = 0.0;
  final _formKey = GlobalKey<FormState>();

  void _calculateBmi({required double weight, required double height}) async {
    setState(() {
      bmiResult = 0;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      bmiResult = weight / pow(height, 2);
      print(bmiResult);
    });
  }

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI SetState'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                BmiGauge(bmiResult: bmiResult),
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
