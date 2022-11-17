import 'package:flutter/material.dart';

import 'bloc_pattern/bmi_bloc_pattern_page.dart';
import 'change_notifier/bmi_change_notifier_page.dart';
import 'setState/bmi_set_state.dart';
import 'value_notifier/bmi_value_notifier_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  void _goToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const BmiSetStatePage());
              },
              child: const Text('SetState'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const BmiValueNotifierPage());
              },
              child: const Text('ValueNotifier'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const BmiChangeNotifierPage());
              },
              child: const Text('Change Notifier'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const BmiBlocPatternPage());
              },
              child: const Text('Bloc Pattern'),
            )
          ],
        ),
      ),
    );
  }
}
