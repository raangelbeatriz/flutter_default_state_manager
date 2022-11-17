import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/bloc_pattern/bmi_bloc_pattern_controller.dart';
import 'package:flutter_default_state_manager/bloc_pattern/bmi_state.dart';
import 'package:intl/intl.dart';

import '../widgets/bmi_gauge.dart';

class BmiBlocPatternPage extends StatefulWidget {
  const BmiBlocPatternPage({Key? key}) : super(key: key);

  @override
  State<BmiBlocPatternPage> createState() => _BmiBlocPatternPageState();
}

class _BmiBlocPatternPageState extends State<BmiBlocPatternPage> {
  final controller = BmiBlocPatternController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  var bmiResult = 0.0;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Bloc Pattern'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                StreamBuilder<BmiState>(
                  stream: controller.bmiOut,
                  builder: ((context, snapshot) {
                    var bmiResult = snapshot.data?.bmiResult ?? 0.0;
                    return BmiGauge(bmiResult: bmiResult);
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                    stream: controller.bmiOut,
                    builder: (context, snapshot) {
                      var dataValue = snapshot.data;
                      if (dataValue is BmiStateLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (dataValue is BmiStateError) {
                        return Center(
                          child: Text(dataValue.message),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
