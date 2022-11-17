import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/change_notifier/bmi_change_notifier.dart';

import 'setState/bmi_set_state.dart';
import 'value_notifier/bmi_value_notifier.dart';

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
                _goToPage(context, const BmiSetState());
              },
              child: const Text('SetState'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const BmiValueNotifier());
              },
              child: const Text('ValueNotifier'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const BmiChangeNotifier());
              },
              child: const Text('Change Notifier'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Bloc Pattern'),
            )
          ],
        ),
      ),
    );
  }
}
