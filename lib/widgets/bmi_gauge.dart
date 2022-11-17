import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'bmi_gauge_range.dart';

class BmiGauge extends StatelessWidget {
  const BmiGauge({
    Key? key,
    required this.bmiResult,
  }) : super(key: key);

  final double bmiResult;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: [
        RadialAxis(
          showLabels: false,
          showAxisLine: true,
          showTicks: false,
          minimum: 12.5,
          maximum: 47.5,
          ranges: [
            BmiGaugeRange(
                color: Colors.blue,
                start: 12.5,
                end: 18.5,
                label: 'UnderWeigth'),
            BmiGaugeRange(
                color: Colors.green,
                start: 18.5,
                end: 24.5,
                label: 'Healthy Weigth'),
            BmiGaugeRange(
                color: Colors.yellow[600]!,
                start: 24.5,
                end: 29.9,
                label: 'Overweight'),
            BmiGaugeRange(
                color: Colors.red[500]!,
                start: 29.5,
                end: 39.9,
                label: 'Obesidy'),
            BmiGaugeRange(
                color: Colors.red[900]!,
                start: 39.9,
                end: 47.5,
                label: 'Severe Obesity'),
          ],
          pointers: [
            NeedlePointer(
              value: bmiResult,
              enableAnimation: true,
            ),
          ],
        ),
      ],
    );
  }
}
