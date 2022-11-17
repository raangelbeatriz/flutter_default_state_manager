import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BmiGaugeRange extends GaugeRange {
  BmiGaugeRange(
      {Key? key,
      required Color color,
      required double start,
      required double end,
      required String label})
      : super(
          key: key,
          startValue: start,
          endValue: end,
          label: label,
          sizeUnit: GaugeSizeUnit.factor,
          color: color,
          startWidth: 0.65,
          endWidth: 0.65,
          labelStyle: const GaugeTextStyle(
            fontFamily: 'Timer',
            fontSize: 12,
          ),
        );
}
