import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/change_notifier/bmi_change_notifier_controller.dart';
import 'package:intl/intl.dart';

import '../widgets/bmi_gauge.dart';

class BmiChangeNotifier extends StatefulWidget {
  const BmiChangeNotifier({Key? key}) : super(key: key);

  @override
  State<BmiChangeNotifier> createState() => _BmiChangeNotifierState();
}

class _BmiChangeNotifierState extends State<BmiChangeNotifier> {
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  var bmiResult = 0.0;
  final _formKey = GlobalKey<FormState>();
  final controller = BmiChangeNotifierController();

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
        title: const Text('BMI ChangeNotifier'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      print('Build animated bmiResult');
                      return BmiGauge(bmiResult: controller.bmiResult);
                    }),
                //BmiGauge(bmiResult: controller.bmiResult),
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
                      controller.calculateBmi(weight: weight, height: height);
                    }
                  },
                  child: const Text('Calculate BMI'),
                ),
                AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      print('Build animated teste');
                      return Text(controller.teste);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
